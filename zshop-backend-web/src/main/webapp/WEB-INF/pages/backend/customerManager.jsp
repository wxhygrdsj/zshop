<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>backend</title>
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/css/bootstrap.css" />
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/css/index.css" />
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/js/userSetting.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/zshop.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrapValidator.min.css"/>
    <script src="${pageContext.request.contextPath}/js/bootstrapValidator.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
<script>
    $(function () {
        var successMsg='${successMsg}';
        var errorMsg='${errorMsg}';

        if(successMsg!=''){
            layer.msg(
                successMsg,
                {
                    time:2000,
                    skin:'successMsg'
                }
            );
        }
        if(errorMsg!=''){
            layer.msg(
                errorMsg,
                {
                    time:2000,
                    skin:'errorMsg'
                }
            );
        }
        $('#pagination').bootstrapPaginator({
            //主版本号
            bootstrapMajorVersion:3,
            //当前页
            currentPage:${data.pageNum},
            //总页数
            totalPages:${data.pages},

            onPageClicked:function(event, originalEvent, type, page){

                //给隐藏表单域赋值
                $('#pageNum').val(page);

                //重新提交表单
                $('#frmQuery').submit();
            },
            itemTexts: function (type, page, current) {
                switch (type) {
                    case "first":
                        return "首页";
                    case "prev":
                        return "上一页";
                    case "next":
                        return "下一页";
                    case "last":
                        return "尾页";
                    case "page":
                        return page;
                }
            }

        });

        //添加表单的初始化校验
        $('#frmModifyCustomer').bootstrapValidator({
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',//成功后输出的图标
                invalid: 'glyphicon glyphicon-remove',//失败后输出的图标
                validating: 'glyphicon glyphicon-refresh'//长时间加载时输出的图标
            },
            fields:{
                name:{
                    validators:{
                        notEmpty:{
                            message:'用户姓名不能为空'
                        }
                    }
                },
                phone:{
                    validators:{
                        notEmpty:{
                            message:'电话号码不能为空'
                        }
                    }
                },
                address:{
                    validators:{
                        notEmpty:{
                            message:'地址不能为空'
                        }
                    }
                }
            }
        });


    });
    //显示修改窗口
    function showCustomer(id) {
        //alert(id);
        $.post('${pageContext.request.contextPath}/backend/customer/findById',
            {"id":id},function (result) {
                console.log(result);
                if(result.status==1){
                    //如果查询成功，将值直接写回修改窗口
                    $('#id').val(result.data.id);
                    $('#name').val(result.data.name);
                    $('#address').val(result.data.address);
                    $('#loginName').val(result.data.loginName);
                    $('#phone').val(result.data.phone);
                    $('#address').val(result.data.address);

                }
            });
    }

    //按条件查询
    function doQuery() {
        //将页面重置为1
        $('#pageNum').val(1);
        //提交表单
        $('#frmQuery').submit();
    }

    //修改用户状态
    function  modifyStatus(id,btn) {
        $.post(
            '${pageContext.request.contextPath}/backend/customer/modifyStatus',
            {"id":id},
            function (result) {
                if(result.status==1){
                    var $td= $(btn).parent().parent().children().eq(5);
                    if($td.text().trim()=='有效'){
                        $td.text('无效');
                        $(btn).val('启用').removeClass('btn-danger').addClass('btn-success');
                    }
                    else{
                        $td.text('有效');
                        $(btn).val('禁用').removeClass('btn-success').addClass('btn-danger');

                    }


                }

            }
        );
    }

</script>
</head>
<body>
<div class="panel panel-default" id="userInfo" id="homeSet">
    <div class="panel-heading">
        <h3 class="panel-title">客户管理</h3>
    </div>
    <div class="panel-body">
        <div class="showusersearch">
            <form class="form-inline" id="frmQuery" action="${pageContext.request.contextPath}/backend/customer/findByParams" method="post">
                <input type="hidden" name="pageNum" id="pageNum" value="${data.pageNum}">
                <div class="form-group">
                    <label for="customer_name">姓名:</label>
                    <input type="text" class="form-control"id="customer_name" name="name" placeholder="请输入姓名" size="15px" value="${customerParam.name}">
                </div>
                <div class="form-group">
                    <label for="customer_loginName">帐号:</label>
                    <input type="text" class="form-control" id="customer_loginName" name="loginName" placeholder="请输入帐号" size="15px" value="${customerParam.loginName}">
                </div>
                <div class="form-group">
                    <label for="customer_phone">电话:</label>
                    <input type="text" class="form-control" id="customer_phone" name="phone" placeholder="请输入电话" size="15px" value="${customerParam.phone}">
                </div>
                <div class="form-group">
                    <label for="customer_address">地址:</label>
                    <input type="text" class="form-control" id="customer_address" name="address" placeholder="请输入地址"value="${customerParam.address}">
                </div>
                <div class="form-group">
                    <label for="customer_isValid">状态:</label>
                    <select class="form-control" id="customer_isValid" name="isValid">
                        <option value="-1">全部</option>
                        <option value="1" <c:if test="${customerParam.isValid==1}">selected</c:if>>---有效---</option>
                        <option value="0" <c:if test="${customerParam.isValid==0}">selected</c:if>>---无效---</option>
                    </select>
                </div>
                <input type="button" value="查询" class="btn btn-primary" id="doSearch" onclick="doQuery()">
            </form>
        </div>

        <div class="show-list text-center" style="position: relative;top: 30px;">
            <table class="table table-bordered table-hover" style='text-align: center'>
                <thead>
                <tr class="text-danger">
                    <th class="text-center">序号</th>
                    <th class="text-center">姓名</th>
                    <th class="text-center">帐号</th>
                    <th class="text-center">电话</th>
                    <th class="text-center">地址</th>
                    <th class="text-center">状态</th>
                    <th class="text-center">操作</th>
                </tr>
                </thead>
                <tbody id="tb">
                 <c:forEach items="${data.list}" var="Customer">
                <tr>
                    <td>${Customer.id}</td>
                    <td>${Customer.name}</td>
                    <td>${Customer.loginName}</td>
                    <td>${Customer.phone}</td>
                    <td>${Customer.address}</td>
                    <td>
                        <c:if test="${Customer.isValid==1}">有效</c:if>
                        <c:if test="${Customer.isValid==0}">无效</c:if>
                    </td>

                    <td class="text-center">
                        <input type="button" class="btn btn-warning btn-sm doModify" value="修改" onclick="showCustomer(${Customer.id},this)">
                        <c:if test="${Customer.isValid==1}">
                        <input type="button" class="btn btn-danger btn-sm doDisable" value="禁用"onclick="modifyStatus(${Customer.id},this)">
                        </c:if>
                        <c:if test="${Customer.isValid==0}">
                            <input type="button" class="btn btn-success btn-sm doDisable" value="启用"onclick="modifyStatus(${Customer.id},this)">
                        </c:if>
                    </td>
                </tr>
                 </c:forEach>
                </tbody>
            </table>
            <ul id="pagination"></ul>
        </div>
    </div>
</div>

<!-- 修改客户信息 start -->
<div class="modal fade" tabindex="-1" id="myModal">
    <!-- 窗口声明 -->
    <div class="modal-dialog">
        <!-- 内容声明 -->
        <form action="${pageContext.request.contextPath}/backend/customer/modify" class="form-horizontal" method="post"  id="frmModifyCustomer">
            <input type="hidden" name="pageNum" value="${data.pageNum}"/>

        <div class="modal-content">
            <!-- 头部、主体、脚注 -->
            <div class="modal-header">
                <button class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">修改客户</h4>
            </div>
            <div class="modal-body text-center">
                <div class="row text-right">
                    <label for="id" class="col-sm-4 control-label" >编号：</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="id"readonly="readonly" name="id">
                    </div>
                </div>
                <br>
                <div class="row text-right">
                    <label for="name" class="col-sm-4 control-label">姓名：</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="name" name="name">
                    </div>
                </div>
                <br>
                <div class="row text-right">
                    <label for="loginName" class="col-sm-4 control-label">帐号：</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="loginName" name="loginName" readonly="readonly">
                    </div>
                </div>
                <br>
                <div class="row text-right">
                    <label for="phone" class="col-sm-4 control-label">电话：</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="phone" name="phone">
                    </div>
                </div>
                <br>
                <div class="row text-right">
                    <label for="address" class="col-sm-4 control-label">地址：</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="address" name="address">
                    </div>
                </div>
                <br>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary updateOne"type="submit">修改</button>
                <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
            </div>
        </div>
        </form>
    </div>
</div>
<!-- 修改客户信息 end -->
</body>

</html>
