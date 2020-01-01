<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>AdminLTE 2 | Starter</title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="${ctx}/plugins/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctx}/plugins/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="${ctx}/plugins/ionicons/css/ionicons.min.css">
    <link rel="stylesheet" href="${ctx}/plugins/adminLTE/css/AdminLTE.min.css">
    <link rel="stylesheet" href="${ctx}/plugins/adminLTE/css/skins/skin-blue.min.css">
</head>
<body>
<div id="frameContent" class="content" style="margin-left:0px;padding-top: 0px;">
    <!-- 标题 -->
    <section class="content-header">
        <h1>
            线路查询
            <small>query route</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="index.html"><i class="fa fa-dashboard"></i>首页</a></li>
            <li class="active">线路管理</li>
        </ol>
    </section>

    <!-- 内容 -->
    <section class="content container-fluid">
        <div class="row">
            <div class="box box-info" style="padding-left: 0px;">
                <!--搜索-->
                <br>
                <form role="form" action="route" method="post">
                    <%--隐藏域提交要调用的方法--%>
                    <input type="hidden" name="action" value="listByPage">
                    <div class="box-body">
                        <div class="form-group">
                            <div class="col-md-6" style="padding-left: 0px;">
                                <input type="text" class="form-control" id="rname" name="rname" value="${rname}" placeholder="请输入线路名字">
                            </div>
                            <div class="col-md-1">
                                <button type="submit" class="btn btn-success" style="width:100px"><i
                                        class="ion-search"></i>查询
                                </button>
                            </div>
                            <div class="col-md-5">
                                <button type="button" class="btn btn-danger" style="width:100px"><i
                                        class="fa fa-fw fa-remove"></i>批量删除
                                </button>
                            </div>
                        </div>
                    </div>
                    <!-- /.box-body -->
                </form>


                <!-- /.box-header -->
                <div class="box-body">
                    <div id="example2_wrapper" class="dataTables_wrapper form-inline dt-bootstrap">
                        <div class="row">
                            <div class="col-sm-6"></div>
                            <div class="col-sm-6"></div>
                        </div>
                        <div class="row">
                            <form action="#" method="post" id="listForm">
                                <table id="example2" class="table table-bordered table-hover dataTable"
                                       role="grid" aria-describedby="example2_info">
                                    <colgroup>
                                        <col width="5%">
                                        <col width="5%">
                                        <col width="10%">
                                        <col width="45%">
                                        <col width="10%">
                                        <col width="10%">
                                        <col width="20%">
                                    </colgroup>
                                    <thead>
                                    <tr role="row">
                                    <tr role="row">
                                        <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1"
                                            colspan="1"
                                            aria-label="Rendering engine: activate to sort column ascending">
                                            <input type="checkbox" id="checkAll">勾选
                                        </th>
                                        <th class="sorting_asc" tabindex="0" aria-controls="example2"
                                            rowspan="1" colspan="1"
                                            aria-label="Browser: activate to sort column descending"
                                            aria-sort="ascending">编号
                                        </th>
                                        <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1"
                                            colspan="1"
                                            aria-label="Platform(s): activate to sort column ascending">
                                            图片
                                        </th>
                                        <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1"
                                            colspan="1"
                                            aria-label="Engine version: activate to sort column ascending">
                                            线路名称
                                        </th>
                                        <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1"
                                            colspan="1"
                                            aria-label="CSS grade: activate to sort column ascending">线路价格
                                        </th>
                                        <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1"
                                            colspan="1"
                                            aria-label="CSS grade: activate to sort column ascending">收藏数量
                                        </th>
                                        <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1"
                                            colspan="1"
                                            aria-label="CSS grade: activate to sort column ascending">操作
                                        </th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%--遍历集合--%>
                                    <c:forEach items="${pageBean.data}" var="route" varStatus="row">
                                        <tr role="row">
                                            <td class=""><input type="checkbox" name="rid"></td>
                                                <%--编号是通过计算得来的--%>
                                            <td class="sorting_1">${(pageBean.current - 1) * pageBean.size + row.count}</td>
                                            <td><img
                                                    src="${route.rimage}"
                                                    width="99px"></td>
                                            <td>${route.rname}</td>
                                            <td>&yen;${route.price}</td>
                                            <td>${route.count}</td>
                                            <td>
                                                <a class="btn btn-primary" href="route_update.jsp" target="iframe"><i
                                                        class="fa fa-fw fa-edit"></i> 修改</a>
                                                <a class="btn btn-danger" href="javascript:delRoute(${route.rid})"><i
                                                        class="fa fa-fw fa-remove"></i> 删除</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>

                                </table>
                            </form>
                        </div>
                        <%--分页部分--%>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="dataTables_info" id="example2_info" role="status"
                                     aria-live="polite">共${pageBean.total}页，共${pageBean.count}条
                                </div>
                            </div>
                            <div class="col-md-9">
                                <div class="dataTables_paginate paging_simple_numbers" id="example2_paginate">
                                    <ul class="pagination" style="margin: 0px">
                                        <li class="paginate_button previous" id="example2_firsts"><a
                                                href="route?action=listByPage&current=${pageBean.first}&rname=${rname}" aria-controls="example2" data-dt-idx="0" tabindex="0">首页</a>
                                        </li>
                                        <li class="paginate_button previous" id="example2_previous"><a
                                                href="route?action=listByPage&current=${pageBean.previous}&rname=${rname}" aria-controls="example2" data-dt-idx="0" tabindex="0">上一页</a>
                                        </li>
                                        <%--页码的显示--%>
                                        <c:forEach var="num" begin="${pageBean.begin}" end="${pageBean.end}">
                                            <%--如果当前页等于num，使用active这个类样式--%>
                                            <li class="paginate_button ${num==pageBean.current?'active':''}">
                                                <a href="route?action=listByPage&current=${num}&rname=${rname}" aria-controls="example2" data-dt-idx="1" tabindex="0">${num}</a>
                                            </li>
                                        </c:forEach>
                                        <li class="paginate_button next" id="example2_next">
                                            <a href="route?action=listByPage&current=${pageBean.next}&rname=${rname}" aria-controls="example2" data-dt-idx="7" tabindex="0">下一页</a>
                                        </li>
                                        <li class="paginate_button next" id="example2_last">
                                            <a href="route?action=listByPage&current=${pageBean.total}&rname=${rname}" aria-controls="example2" data-dt-idx="7" tabindex="0">尾页</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.box-body -->
            </div>
        </div>
        <!-- /.row -->
    </section>
    <!-- /内容 -->
</div>
<script src="${ctx}/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="${ctx}/plugins/bootstrap/js/bootstrap.min.js"></script>
<script src="${ctx}/plugins/adminLTE/js/adminlte.js"></script>
<script src="${ctx}/plugins/common.js"></script>

<script type="text/javascript">
    //删除1条线路
    function delRoute(rid) {
        if (confirm("真的要删除这条线路吗?")) {
            location.href = "route?action=delRoute&rid=" + rid;
        }
    }
</script>
</body>
</html>