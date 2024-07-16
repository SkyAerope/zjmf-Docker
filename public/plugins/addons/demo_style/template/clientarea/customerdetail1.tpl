  <section class="admin-main">
    <div class="container-fluid">
      <div class="page-container">
        <div class="card">
          <div class="card-body">
            <div class="card-title row"> <div style="padding:0 15px;">{$Title}</div>
              <div class="col-lg-8 col-md-12 col-sm-12">
                {foreach $PluginsAdminMenu as $v}
                  {if $v['custom']}
                    <span  class="ml-2"><a  class="h5" href="{$v.url}" target="_blank">{$v.name}</a></span>
                  {else/}
                    <span  class="ml-2"> <a  class="h5" href="{$v.url}">{$v.name}</a></span>
                  {/if}
                {/foreach}
              </div>
            </div>
            <div class="tabs">
              <div class="tab-item selected">客户摘要</div>
              <div class="tab-item">个人资料</div>
              <div class="tab-item">产品/服务</div>
              <div class="tab-item">账单</div>
              <div class="tab-item">交易记录</div>
              <div class="tab-item">信用管理</div>
              <div class="tab-item">工单</div>
              <div class="tab-item">日志</div>
              <div class="tab-item">通知日志</div>
              <div class="tab-item">附件</div>
              <div class="tab-item">跟进状态</div>
            </div>
            <div class="tab-content mt-4">
              <div class="table-body">
                <form class="form">
                  <div class="form-group row invalid">
                    <label class="require">帮助标题</label>
                    <div class="col-sm-4">
                      <input type="text" class="form-control">
                      <div class="invalid-feedback">
                        Please provide a valid city.
                      </div>
                    </div>
                  </div>

                  <div class="form-group row">
                    <label class="require">分类
                      <i class="far fa-question-circle" style="color: blue;" aria-hidden="true" data-toggle="tooltip"
                        data-placement="top" title="Tooltip on top"></i>
                    </label>
                    <div class="col-sm-4">
                      <select class="form-control">
                        <option value="1">选项1</option>
                        <option value="2">选项2</option>
                        <option value="3">选项3</option>
                      </select>
                      <div class="invalid-feedback">
                        Please provide a valid city.
                      </div>
                    </div>
                  </div>

                  <div class="form-group row invalid">
                    <label>是否隐藏</label>
                    <div class="col-sm-4">
                      <div class="custom-control custom-switch" dir="ltr">
                        <input type="checkbox" class="custom-control-input" id="customSwitchsizemd">
                        <label class="custom-control-label" for="customSwitchsizemd"></label>
                      </div>
                    </div>
                  </div>

                  <div class="form-group row">
                    <label class="require">日期选择</label>
                    <div class="col-sm-4">
                      <input type="text" class="form-control datetime">
                    </div>
                  </div>

                  <div class="form-group row">
                    <label>标签</label>
                    <div class="col-sm-4">
                      <input type="text" class="form-control">
                    </div>
                  </div>

                  <div class="form-group row">
                    <label>描述</label>
                    <div class="col-sm-4">
                      <input type="text" class="form-control">
                    </div>
                  </div>


                  <div class="form-group row">
                    <label>文章内容</label>
                    <div class="col-sm-4">
                      <textarea rows="5" class="form-control"></textarea>
                    </div>
                  </div>
                </form>

                <div class="form-group row">
                  <div class="col-sm-10">
                    <button type="submit" class="btn btn-primary w-md">保存更改</button>
                    <button type="submit" class="btn btn-outline-secondary w-md">取消更改</button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>