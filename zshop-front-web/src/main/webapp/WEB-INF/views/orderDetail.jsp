<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: 26615
  Date: 2021/7/3
  Time: 17:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>订单详情</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
</head>

<body>
<%request.setAttribute("index",1);%>
<jsp:include page="top.jsp"/>
<!-- content start -->
<div class="container">
    <div class="row">
        <div class="col-xs-12">
            <div class="page-header" style="margin-bottom: 0px;">
                <h3>我的订单</h3>
            </div>
        </div>
    </div>
    <div class="row head-msg">
        <div class="col-md-12">
            用户:<b><span>${customer.name}</span></b>
        </div>
        <div class="col-md-12">
            订单: <b><span>${order.no}</span></b>
        </div>
    </div>
    <table class="table table-hover table-striped table-bordered">
        <tr>
            <th>序号</th>
            <th>商品名称</th>
            <th>商品图片</th>
            <th>商品数量</th>
            <th>商品单价</th>
            <th>商品总价</th>
        </tr>
        <c:forEach items="${order.orderItemList}" var="orderItem" varStatus="s">
        <tr>
            <td>${s.count}</td>
            <td>${orderItem.product.name}</td>
            <td> <img src="${pageContext.request.contextPath}/front/product/showPic?image=${orderItem.product.image}" alt="" width="60" height="60"></td>
            <td>${orderItem.num}</td>
            <td><fmt:formatNumber value="${orderItem.product.price}" pattern="0.00"/></td>
            <td><fmt:formatNumber value="${orderItem.price}" pattern="0.00"/></td>
        </tr>

        </c:forEach>
        <tr>
            <td colspan="5" class="foot-msg">
                共<b><span>${order.totalNum}</span></b>条&nbsp; &nbsp; 总计
                <b><span><fmt:formatNumber value="${order.price}" pattern="0.00"/></span></b>元
            </td>
        </tr>
    </table>
</div>
<!-- content end-->
<!-- footers start -->
<div class="footers">
    版权所有：中兴软件技术
</div>
<!-- footers end -->

</body>

</html>