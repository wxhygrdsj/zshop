<%--
  Created by IntelliJ IDEA.
  User: 26615
  Date: 2021/6/1
  Time: 12:03
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

    <script>
        $(function () {
            $('#pagination').bootstrapPaginator({
                bootstrapMajorVersion:3,
                currentPage:${data.pageNum},
                totalPages:${data.pages},
                pageUrl: function (type, page, current) {
                    if(current==page){
                        return "javascript:void(0)";
                    }
                    return "${pageContext.request.contextPath}/backend/productType/findAll?pageNum="+page;
                },
                itemTexts: function (type, page, current) {
                    switch (type) {
                        case "first":
                            return "&lt;&lt;";
                        case "prev":
                            return "&lt;";
                        case "next":
                            return "&gt;";
                        case "last":
                            return "&gt;&gt;";
                        case "page":
                            return page;
                    }
                }

            });
        })

        //??????????????????
        function  addProductType() {
            $.post(
                '${pageContext.request.contextPath}/backend/productType/add',
                {"name":$('#productTypeName').val()},
                function (data) {
                    //console.log(data);
                    if(data.status==1){
                        //?????????????????????
                        layer.msg(
                            data.message,//????????????
                            {
                                time:2000,//??????2??????????????????
                                skin:"successMsg"//??????????????????????????????zshop.css
                            },
                            function () {

                                location.href="${pageContext.request.contextPath}/backend/productType/findAll?pageNum="+${data.pageNum};
                            }
                        );
                    }
                    else{
                        //?????????????????????
                        layer.msg(
                            data.message,
                            {
                                time:2000,
                                skin:"errorMsg"
                            }
                        );
                    }

                }
            );
        }
        //??????????????????????????????
        function  showProductType(id) {
            //alert(id);
            $.post(
                '${pageContext.request.contextPath}/backend/productType/findById',
                {"id":id},
                function (result) {
                    //console.log(result);
                    //????????????????????????
                    $('#proTypeNum').val(result.data.id);
                    $('#proTypeName').val(result.data.name);
                }
            );
        }
        //????????????????????????
        function  modifyName() {




           // console.log($('#name'+id).text());
            $.ajax({
                type:"post",
                url:"${pageContext.request.contextPath}/backend/productType/modifyName",
                data:{"id":$("#proTypeNum").val(),"name":$("#proTypeName").val()},
                success:function (data) {
                    console.log(data);
                    if(data.status==1){
                        layer.msg(
                            data.message,
                            {
                                time:2000,
                                skin:"successMsg"
                            },
                            function () {
                                console.log(data.data.name);
                                //???????????????????????????,??????data???????????????data,??????????????????data,???data?????????pegeInfo??????
                                //$("#proTypeName").val(data.data.name);
                                //_this.parent().parent().children(0).val(data.data.name);
                               // let name=$('#tb tr:first td:first').text();
                               // console.log(name);
                                //$('#tb').children(0).children(0).val(data.data.name);
                               /*console.log($(name).text());
                               console.log($('#name17').text());*/
                                let id=$('#proTypeNum').val();
                                $('#name'+id).text(data.data.name);
                            }
                        );
                    }
                    else{
                        layer.msg(
                            data.message,
                            {
                                time:2000,
                                skin:"errorMsg"
                            }
                        )
                    }
                }

            });
        }

        //???????????????????????????
        function showDelModel(id) {
            //alert(id);
            //???id?????????????????????
            $('#productTypeId').val(id);
            //??????????????????
            $('#delProductType').modal("show");
        }

        //??????????????????
        function  delProductType() {
            $.post(
                '${pageContext.request.contextPath}/backend/productType/deleteById',
                {"id":$('#productTypeId').val()},
                function (data) {
                    if(data.status==1){
                        layer.msg(
                            data.message,
                            {
                                time:2000,
                                skin:"successMsg"
                            },
                            function () {
                                //?????????????????????????????????
                                location.href="${pageContext.request.contextPath}/backend/productType/findAll?pageNum="+${data.pageNum};
                            }
                        );
                    }
                    else{
                        layer.msg(
                            data.message,
                            {
                                time:2000,
                                skin:"errorMsg"
                            }
                        );
                    }
                }
            );
        }

        function  modifyStatus(id,btn){
            $.post(
                "${pageContext.request.contextPath}/backend/productType/modifyStatus",
                {"id":id},
                function () {
                    let $td=$(btn).parent().prev()
                    if($td.text().trim()=='??????'){
                        $td.text('??????');
                        $(btn).val('??????').removeClass('btn-danger').addClass('btn-success');

                    }else if($td.text().trim()=='??????'){
                        $td.text('??????');
                        $(btn).val('??????').removeClass('btn-success').addClass('btn-danger');
                    }

                }

            )

        }



    </script>
</head>

<body>
<div class="panel panel-default" id="userSet">
    <div class="panel-heading">
        <h3 class="panel-title">??????????????????</h3>
    </div>
    <div class="panel-body">
        <input type="button" value="??????????????????" class="btn btn-primary" id="doAddProTpye">
        <br>
        <br>
        <div class="show-list text-center">
            <table class="table table-bordered table-hover" style='text-align: center;'>
                <thead>
                <tr class="text-danger">

                    <th class="text-center">????????????</th>
                    <th class="text-center">??????</th>
                    <th class="text-center">??????</th>
                </tr>
                </thead>
                <tbody id="tb">
                <c:forEach items="${data.list}" var="productType" varStatus="s">
                    <tr>
                        <td id="name${productType.id}">${productType.name}</td>
                        <td>
                            <c:if test="${productType.status==1}">??????</c:if>
                            <c:if test="${productType.status==0}">??????</c:if>
                        </td>
                        <td class="text-center">
                            <input type="button" class="btn btn-warning btn-sm doProTypeModify" value="??????" onclick="showProductType(${productType.id})">
                            <input type="button" class="btn btn-warning btn-sm doProTypeDelete" value="??????" onclick="showDelModel(${productType.id})">
                            <c:if test="${productType.status==1}">
                                <input type="button" class="btn btn-danger btn-sm doProTypeDisable" value="??????" onclick="modifyStatus(${productType.id},this)">

                            </c:if>
                            <c:if test="${productType.status==0}">
                                <input type="button" class="btn btn-success btn-sm doProTypeDisable" value="??????" onclick="modifyStatus(${productType.id},this)">

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

<!-- ?????????????????? start -->
<div class="modal fade" tabindex="-1" id="ProductType">
    <!-- ???????????? -->
    <div class="modal-dialog modal-lg">
        <!-- ???????????? -->
        <div class="modal-content">
            <!-- ???????????????????????? -->
            <div class="modal-header">
                <button class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">??????????????????</h4>
            </div>
            <div class="modal-body text-center">
                <div class="row text-right">
                    <label for="productTypeName" class="col-sm-4 control-label">???????????????</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="productTypeName">
                    </div>
                </div>
                <br>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary addProductType" onclick="addProductType()">??????</button>
                <button class="btn btn-primary cancel" data-dismiss="modal">??????</button>
            </div>
        </div>
    </div>
</div>
<!-- ?????????????????? end -->

<!-- ?????????????????? start -->
<div class="modal fade" tabindex="-1" id="myProductType">
    <!-- ???????????? -->
    <div class="modal-dialog modal-lg">
        <!-- ???????????? -->
        <div class="modal-content">
            <!-- ???????????????????????? -->
            <div class="modal-header">
                <button class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">??????????????????</h4>
            </div>
            <div class="modal-body text-center">
                <div class="row text-right">
                    <label for="proTypeNum" class="col-sm-4 control-label">?????????</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="proTypeNum" readonly>
                    </div>
                </div>
                <br>
                <div class="row text-right">
                    <label for="proTypeName" class="col-sm-4 control-label">????????????</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="proTypeName">
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-warning updateProType" onclick="modifyName()">??????</button>
                <button class="btn btn-primary cancel" data-dismiss="modal">??????</button>
            </div>
        </div>
    </div>
</div>
<!-- ?????????????????? end -->
<!-- ?????????????????? start -->
<div class="modal fade" tabindex="-1" id="delProductType">
    <!-- ???????????? -->
    <div class="modal-dialog modal-sm">
        <!-- ???????????? -->
        <div class="modal-content">
            <!-- ???????????????????????? -->
            <div class="modal-header">
                <button class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">????????????</h4>
            </div>
            <div class="modal-body text-left">
                <h4>????????????????????????????????????</h4>
            </div>
            <input type="hidden" id="productTypeId"/>

            <div class="modal-footer">
                <button class="btn btn-warning updateProType" onclick="delProductType()">??????</button>
                <button class="btn btn-primary cancel" data-dismiss="modal">??????</button>
            </div>
        </div>
    </div>
</div>
<!-- ?????????????????? end -->
</body>

</html>
