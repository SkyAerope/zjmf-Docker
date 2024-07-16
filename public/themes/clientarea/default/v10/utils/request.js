const baseURL = location.origin + '/';
const Axios = axios.create({ baseURL, timeout: 40000 });
Axios.defaults.withCredentials = true;

// 请求拦截器
Axios.interceptors.request.use((config) => {
    config.headers.Authorization = "Bearer" + " " + localStorage.getItem("jwt");
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

// 响应拦截器
Axios.interceptors.response.use(
  (response) => {
    const code = response.data.status;
    if (response.data.rule) {
      // 返回有rule的时候, 才执行缓存操作
      localStorage.setItem("menuList", JSON.stringify(response.data.rule)); // 权限菜单
    }
    if (code) {
      switch (code) {
        case 200:
          break;
        case 302:
          location.href = `${baseURL}/install`;
          break;
        case 307:
          break;
        case 400:
          return Promise.reject(response);
        case 401: // 未授权:2个小时未操作自动退出登录
          // 几个特定页面不跳转登录页面
          // if (!noNeedJwtUrlArr.includes(pageRouter)) {
          //   localStorage.removeItem("jwt");
          //   sessionStorage.redirectUrl = location.href
          //   location.href = `/login.htm`;
          // }
          return Promise.reject(response)
        case 403:
          break;
        case 404:
          if (response.request.responseURL == 'http://kfc.idcsmart.com/console/v1/cart') {
            console.log('购物车接口返回404')

            return Promise.reject(response)
          } else {
            //  location.href = "/NotFound.htm";
            console.log(response);
            return Promise.reject(response)
          }
          case 405:
            location.href = "/login.htm";
            break;
          case 406:
            break;
          case 409: // 该管理没有该客户, 跳转首页
            location.href = "";
            break;
          case 410:
            break;
          case 422:
            break;
          case 500:
            this.$message.error("访问失败, 请重试!");
            break;
          case 501:
            break;
          case 502:
            break;
          case 503:
            location.href = "/503.htm";
            break;
          case 504:
            break;
          case 505:
            break;
      }
    }

    return response;
  },
  (error) => {
    console.log("error:", error);
    if (error.code === "ERR_NETWORK") {
      location.href = `/NetworkErro.htm`;
    }
    if (error.config) {
      if (error.config.url.indexOf("system/autoupdate") !== -1) {
        // 系统更新接口
        if (error.message === "Network Error") {
          setTimeout(() => {
            location.reload();
          }, 2000);
        }
      }
    }
    if (error.response) {
      if (error.response.status === 302) {
        location.href = `${baseURL}/install`;
      }
    }
    return Promise.reject(error);
  }
);
