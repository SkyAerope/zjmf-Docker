<!DOCTYPE html>
<html>
<head>
    <!--
    noVNC example: lightweight example using minimal UI and features

    This is a self-contained file which doesn't import WebUtil or external CSS.

    Copyright (C) 2012 Joel Martin
    Copyright (C) 2018 Samuel Mannehed for Cendio AB
    noVNC is licensed under the MPL 2.0 (see LICENSE.txt)
    This file is licensed under the 2-Clause BSD license (see LICENSE.txt).

    Connect parameters are provided in query string:
        http://example.com/?host=HOST&port=PORT&scale=true
    -->
    <title>noVNC</title>

    <meta charset="utf-8">

    <!-- Always force latest IE rendering engine (even in intranet) &
        Chrome Frame. Remove this if you use the .htaccess -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

    <style type="text/css">

        body {
            margin: 0;
            background-color: dimgrey;
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        html {
            height: 100%;
        }

        #top_bar {
            background-color: #6e84a3;
            color: white;
            font: bold 12px Helvetica;
            padding: 6px 5px 4px 5px;
            border-bottom: 1px outset;
        }
        #status {
            text-align: center;
        }
        #sendCtrlAltDelButton {
            position: fixed;
            top: 0px;
            right: 0px;
            border: 1px outset;
            padding: 5px 5px 4px 5px;
            cursor: pointer;
        }
        #paste {
            position: fixed;
            top: 0px;
            right: 130px;
            border: none;
            padding: 5px 5px 4px 5px;
            cursor: pointer;
        }
        #pastePassword{
            position: fixed;
            top: 0px;
            right: 200px;
            border: none;
            padding: 5px 5px 4px 5px;
            cursor: pointer;
        }
        .vnc_restart{
            position: fixed;
            top: 0px;
            left: 0px;
            border: none;
            padding: 5px 5px 4px 5px;
            cursor: pointer;
        }
        #screen {
            flex: 1; /* fill remaining space */
            overflow: hidden;
        }
    </style>

    <!-- Promise polyfill for IE11 -->
    <script src="{$Request.domain}/themes/clientarea/default/v10/viewdcim/noVNC/vendor/promise.js"></script>
    <script src="{$Request.domain}/themes/clientarea/default/v10/viewdcim/noVNC/utils/jquery.min.js"></script>

    <!-- ES2015/ES6 modules polyfill -->
    <script type="module">
        window._noVNC_has_module_support = true;
    </script>
    <script>
        window.addEventListener("load", function() {
            var title = /&title=([^&]+)/.exec(location.href);
            if(title){
                document.title = title[1];
            }
            if (window._noVNC_has_module_support) return;
            const loader = document.createElement("script");
            loader.src = "{$Request.domain}/themes/clientarea/default/v10/viewdcim/noVNC/vendor/browser-es-module-loader/dist/" +
                "browser-es-module-loader.js";
            document.head.appendChild(loader);
        });

        document.onkeydown = function(e){
            e = window.event || e;
            var k = e.keyCode;
            //屏蔽ctrl+R，F5键，ctrl+F5键  F3键！验证
            if ((e.ctrlKey == true && k == 82) || (k == 116)
                    || (e.ctrlKey == true && k == 116)||k==114) {
                e.keyCode = 0;
                e.returnValue = false;
                e.cancelBubble = true;
                return false;
            }
        }

    </script>

    <!-- actual script modules -->
    <script type="module" crossorigin="anonymous">
        // RFB holds the API to connect and communicate with a VNC server
        import RFB from '{$Request.domain}/themes/clientarea/default/v10/viewdcim/noVNC/core/rfb.js';

        let rfb;
        let desktopName;
        let _status = 0;
        var retry_task;
        const host = readQueryVariable('host', window.location.hostname);
        let port = readQueryVariable('port', window.location.port);
        const password = readQueryVariable('password', '{$vnc_pass}');
        const path = readQueryVariable('path', 'websockify');
        let url;

        // When this function is called we have
        // successfully connected to a server
        function connectedToServer(e) {
            status("Connected to " + desktopName);
        }

        // This function is called when we are disconnected
        function disconnectedFromServer(e) {
            if (e.detail.clean) {
                status("Disconnected");
                if(_status == 1){
                    status("{:lang_plugins('vnc_refresh_please_wait')}");
                }
            } else {
                status("Something went wrong, connection is closed");
            }
            if(_status == 0){
                
            }
        }

        // When this function is called, the server requires
        // credentials to authenticate
        function credentialsAreRequired(e) {
            const password = prompt("Password Required:");
            rfb.sendCredentials({ password: password });
        }

        // When this function is called we have received
        // a desktop name from the server
        function updateDesktopName(e) {
            desktopName = e.detail.name;
        }

        // Since most operating systems will catch Ctrl+Alt+Del
        // before they get a chance to be intercepted by the browser,
        // we provide a way to emulate this key sequence.
        function sendCtrlAltDel() {
            rfb.sendCtrlAltDel();
            return false;
        }
        function get_cookie(name) {
            var reg = new RegExp("(^| )"+name+"=([^;]*)(;|$)");
            var arr = document.cookie.match(reg)
            if(arr) return unescape(arr[2]); 
            return null;        
        }

        // Show a status text in the top bar
        function status(text) {
            document.getElementById('status').textContent = text;
        }

        // This function extracts the value of one variable from the
        // query string. If the variable isn't defined in the URL
        // it returns the default value instead.
        function readQueryVariable(name, defaultValue) {
            // A URL with a query parameter can look like this:
            // https://www.example.com?myqueryparam=myvalue
            //
            // Note that we use location.href instead of location.search
            // because Firefox < 53 has a bug w.r.t location.search
            const re = new RegExp('.*[?&]' + name + '=([^&#]*)'),
                  match = document.location.href.match(re);
            if (typeof defaultValue === 'undefined') { defaultValue = null; }

            if (match) {
                // We have to decode the URL since want the cleartext value
                return decodeURIComponent(match[1]);
            }

            return defaultValue;
        }

	    function getSearch(){
            let s = location.search;
            let res = '';
            if(s.indexOf('&') != -1){
                let arr = s.split('&');
                if(/p/.test(arr[1])){
                    res = arr[1].replace('p=', '');
                }
            }
            return res;
        }

        document.getElementById('sendCtrlAltDelButton')
            .onclick = sendCtrlAltDel;

        // Read parameters specified in the URL query string
        // By default, use the host and port of server that served this file
	

        // | | |         | | |
        // | | | Connect | | |
        // v v v         v v v

        status("Connecting");

        url = '{$vnc_url}';

        // Creating a new RFB object will start a new connection
        rfb = new RFB(document.getElementById('screen'), url,
                      { credentials: { password: password } });

        // Add listeners to important events from the RFB module
        rfb.addEventListener("connect", connectedToServer);
        rfb.addEventListener("disconnect", disconnectedFromServer);
        rfb.addEventListener("credentialsrequired", credentialsAreRequired);
        rfb.addEventListener("desktopname", updateDesktopName);
        
        // Set parameters that can be changed on an active connection
        rfb.viewOnly = readQueryVariable('view_only', false);
        rfb.scaleViewport = readQueryVariable('scale', false);

        $('#paste').click(function(){
            rfb.focus();
            var t = prompt("输入要发送到控制台的文本,(这不会发送回车键)").split('');
            paste(rfb, t);
            return false;
        })

        $('#pastePassword').click(function(){
            rfb.focus();
            paste(rfb, '{$password}');
        })

        // var lock_cap = false;
        function paste(rfb, t) {
            if(!t){
                return ;
            }
            // return rfb.clipboardPasteFrom(t);
            // var data = [];
            for (let letter of t) {
                // data.push(letter);
                var character = letter;
                // var i = [];
                var code = character.charCodeAt();
                var needs_shift = "!@#$%^&*()_+{}:\"<>?~|".indexOf(character) !== -1
                // var needs_cap = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".indexOf(character) !== -1
                // var cancel_cap = !needs_cap
                var shift = '0xffe1';
                // var cap = '0xffe5';
                if (needs_shift) {
                    rfb.sendKey(shift, 'XK_Shift_L', 1);
                }
                rfb.sendKey(code, character, 1);
                rfb.sendKey(code, character, 0);
                if (needs_shift) {
                    rfb.sendKey(shift, 'XK_Shift_L', 0);
                }
            }
            // if (data.length > 0) {
            //     setTimeout(function(){
            //         paste(rfb, data)
            //     }, 10);
            // }
        }
    </script>
    <script type="text/javascript">
        function readQueryVariable(name, defaultValue) {
            // A URL with a query parameter can look like this:
            // https://www.example.com?myqueryparam=myvalue
            //
            // Note that we use location.href instead of location.search
            // because Firefox < 53 has a bug w.r.t location.search
            const re = new RegExp('.*[?&]' + name + '=([^&#]*)'),
                  match = document.location.href.match(re);
            if (typeof defaultValue === 'undefined') { defaultValue = null; }

            if (match) {
                // We have to decode the URL since want the cleartext value
                return decodeURIComponent(match[1]);
            }

            return defaultValue;
        }
    </script>


</head>

<body>
    <div id="top_bar">
        <div id="status">Loading</div>
        <div id="pastePassword">粘贴密码</div>
        <div id="paste">剪切板</div>
        <div id="sendCtrlAltDelButton">Send CtrlAltDel</div>
    </div>
    <div id="screen">
        <!-- This is where the remote screen will appear -->
    </div>
</body>
</html>
