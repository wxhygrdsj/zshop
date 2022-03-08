<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>在线商城-后台管理系统</title>
    <meta charset="utf-8">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrapValidator.min.css"/>
    <script src="${pageContext.request.contextPath}/js/bootstrapValidator.min.js"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js"></script>
    <script>
        function check(){
            $('#frmLogin').bootstrapValidator({
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',//成功后输出的图标
                    invalid: 'glyphicon glyphicon-remove',//失败后输出的图标
                    validating: 'glyphicon glyphicon-refresh'//长时间加载时输出的图标
                },
                fields:{
                    loginName:{
                        validators:{
                            notEmpty:{
                                message:'登录名不能为空'
                            }
                        }
                    },
                    password:{
                        validators: {
                            notEmpty: {
                                message:'密码不能为空'
                            }
                        }
                    },
                    code:{
                        validators:{
                            notEmpty:{

                                message:'请输入验证码'
                            },
                            remote:{
                                url:'${pageContext.request.contextPath}/backend/code/verify',
                                message:'验证码错误'

                            }
                        }
                    }
                }
            });
        }
        $(function () {
           check();

            //服务端校验
            var errorMsg='${errorMsg}';
            if(errorMsg!=''){
                layer.msg(
                    errorMsg,
                    {
                        time:2000,
                        skin:'errorMsg'
                    }
                );
            }
        });

        function resetForm(formName){
            document.getElementById(formName).reset();
            $("#"+formName).data('bootstrapValidator').destroy();
            $("#"+formName).data('bootstrapValidator',null);
            check();
        }



        function reloadImage() {
            $('#randImage').attr('src','${pageContext.request.contextPath}/backend/code/captcha?time='+new Date().getTime());
            //将原来的验证码清空
            $('#code').val('');
        }
        
    </script>
</head>
<body>
            <form id="frmLogin" action="${pageContext.request.contextPath}/backend/sysuser/login" class="form-horizontal" method="post">
                <div class="form-group">
                    <label class="col-sm-3 control-label">验证码：</label>
                    <div class="col-sm-4">
                        <input class="form-control" type="text" placeholder="验证码" id="code" name="code">
                    </div>
                    <div class="col-sm-2">
                        <!-- 验证码 -->
                        <img class="img-rounded" id="randImage" src="${pageContext.request.contextPath}/backend/code/captcha" style="height: 32px; width: 70px;"/>
                    </div>
                    <div class="col-sm-2">
                        <button type="button" class="btn btn-link" onclick="reloadImage()">看不清</button>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-3">
                    </div>
                    <div class="col-sm-9 padding-left-0">
                        <div class="col-sm-4">
                            <button type="submit" class="btn btn-primary btn-block">登&nbsp;&nbsp;陆</button>
                        </div>
                        <div class="col-sm-4">
                            <button type="button" class="btn btn-primary btn-block"  onclick="resetForm('frmLogin')">重&nbsp;&nbsp;置</button>
                        </div>
                        <div class="col-sm-4">
                            <button type="button" class="btn btn-link btn-block">忘记密码？</button>
                        </div>
                    </div>
                </div>
            </form>
            <!-- login form end -->
        </div>
    </div>
</div>

</body>
</html>
