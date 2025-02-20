<%-- File Location: /views/admin/user_info/manage.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}/" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>코쿤스토어</title>
	<script src="${root}js/adminlte.min.js"></script>
	<script src="${root}js/bootstrap.bundle.min.js"></script>
	<script src="${root}js/jquery.min.js"></script>
	<script src="${root}js/locales-all.min.js"></script>
	<script src="${root}js/tempusdominus-bootstrap-4.min.js"></script>
    <link rel="stylesheet" href="${root}css/adminlte.min.css">
    <link rel="stylesheet" href="${root}css/all.min.css">
    <link rel="stylesheet" href="${root}css/fontawesome.min.css">
    <link rel="stylesheet" href="${root}css/icheck-bootstrap.min.css">
    <link rel="stylesheet" href="${root}css/tempusdominus-bootstrap-4.min.css">
</head>
<body class="hold-transition sidebar-mini">
<div class="wrapper">
    <c:import url="/WEB-INF/views/admin_include/top_menu.jsp"></c:import>
    <c:import url="/WEB-INF/views/admin_include/left_menu.jsp"></c:import>
    <div class="content-wrapper">
        <section class="content">
            <div class="container-fluid">
                <h1>유저 관리</h1>
                <div class="card">
                    <div class="card-header">
                        <div class="card-tools">
                            <button type="button" class="btn btn-secondary btn-sm" onclick="toggleSearch()">상세 검색</button>
                        </div>
                        <div id="searchForm" style="display:none; margin-top:10px;">
                            <form action="${root}admin/userInfo/search?returnJSP=manageJSP" method="post" onsubmit="removeEmptyFields(event)">
                                <div class="input-group input-group-sm" style="width: 100%;">
                                    <div class="form-group" style="width: 100%;">
                                        <label for="user_name">유저 이름</label>
                                        <input type="text" name="user_name" class="form-control" placeholder="유저 이름" value="${filter.user_name}">
                                    </div>
                                    <div class="form-group" style="width: 100%;">
                                        <label for="user_nickname">닉네임</label>
                                        <input type="text" name="user_nickname" class="form-control" placeholder="닉네임" value="${filter.user_nickname}">
                                    </div>
                                    <div class="form-group" style="width: 100%;">
                                        <label for="user_id">로그인 ID</label>
                                        <input type="text" name="user_id" class="form-control" placeholder="로그인 ID" value="${filter.user_id}">
                                    </div>
                                    <div class="form-group" style="width: 100%;">
                                        <label for="email">이메일</label>
                                        <input type="text" name="email" class="form-control" placeholder="이메일" value="${filter.email}">
                                    </div>
                                    <div class="form-group" style="width: 100%;">
                                        <label for="address">주소</label>
                                        <input type="text" name="address" class="form-control" placeholder="주소" value="${filter.address}">
                                    </div>
                                    <div class="input-group-append">
                                        <button type="submit" class="btn btn-default"><i class="fas fa-search"></i></button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="card-body table-responsive p-0">
                        <table class="table table-hover text-nowrap">
                            <thead>
                                <tr>
                                    <th><a href="${root}admin/userInfo/sort?returnJSP=manageJSP&sortField=userIdx">ID <i class="fas ${filter.userIdxOrder == 'asc' ? 'fa-sort-up' : filter.userIdxOrder == 'desc' ? 'fa-sort-down' : 'fa-sort'}"></i></a></th>
                                    <th>관리</th>
                                    <th>사진</th>
                                	<th><a href="${root}admin/userInfo/sort?returnJSP=manageJSP&sortField=userName">이름 <i class="fas ${filter.userNameOrder == 'asc' ? 'fa-sort-up' : filter.userNameOrder == 'desc' ? 'fa-sort-down' : 'fa-sort'}"></i></a></th>
                                    <th><a href="${root}admin/userInfo/sort?returnJSP=manageJSP&sortField=userNickname">닉네임 <i class="fas ${filter.userNicknameOrder == 'asc' ? 'fa-sort-up' : filter.userNicknameOrder == 'desc' ? 'fa-sort-down' : 'fa-sort'}"></i></a></th>
                                    <th><a href="${root}admin/userInfo/sort?returnJSP=manageJSP&sortField=userId">유저 ID <i class="fas ${filter.userIdOrder == 'asc' ? 'fa-sort-up' : filter.userIdOrder == 'desc' ? 'fa-sort-down' : 'fa-sort'}"></i></a></th>
                                    <th><a href="${root}admin/userInfo/sort?returnJSP=manageJSP&sortField=email">이메일 <i class="fas ${filter.emailOrder == 'asc' ? 'fa-sort-up' : filter.emailOrder == 'desc' ? 'fa-sort-down' : 'fa-sort'}"></i></a></th>
                                    <th><a href="${root}admin/userInfo/sort?returnJSP=manageJSP&sortField=address">주소 <i class="fas ${filter.addressOrder == 'asc' ? 'fa-sort-up' : filter.addressOrder == 'desc' ? 'fa-sort-down' : 'fa-sort'}"></i></a></th>
                            	</tr>
                            </thead>
                            <tbody>
                                <c:forEach var="user" items="${userList}">
                                    <tr>
                                        <td><a href="${root}admin/userInfo/detail/${user.user_idx}">${user.user_idx}</a></td>
                                        <td>
                                            <a href="${root}admin/userInfo/modify/${user.user_idx}" class="btn btn-primary btn-sm">수정</a>
                                            <button class="btn btn-danger btn-sm" onclick="confirmDelete(${user.user_idx})">삭제</button>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${user.user_pic != null}">
                                                    <img src="${root}upload/${user.user_pic}" alt="사진" class="img-thumbnail" style="max-width: 150px;">
                                                </c:when>
                                                <c:otherwise> X </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${user.user_name}</td>
                                        <td>${user.user_nickname}</td>
                                        <td>${user.user_id}</td>
                                        <td>${user.email}</td>
                                        <td>${user.address}</td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty userList}">
                                    <tr>
                                        <td colspan="6" class="text-center">데이터 없음</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                    <div class="card-footer clearfix">
                        <ul class="pagination pagination-sm m-0 float-right">
                            <c:choose>
                                <c:when test="${pageBean.prevPage <= 0}">
                                    <li class="paginate_button page-item previous disabled"><a class="page-link" href="#">이전</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li class="paginate_button page-item previous"><a class="page-link" href="?page=${pageBean.prevPage}&pageChange=true">이전</a></li>
                                </c:otherwise>
                            </c:choose>
                            <c:forEach var="idx" begin="${pageBean.min}" end="${pageBean.max}">
                                <li class="page-item ${pageBean.currentPage == idx ? 'active' : ''}">
                                    <a class="page-link" href="?page=${idx}&pageChange=true">${idx}</a>
                                </li>
                            </c:forEach>
                            <c:choose>
                                <c:when test="${pageBean.max >= pageBean.pageCnt}">
                                    <li class="paginate_button page-item next disabled"><a class="page-link" href="#">다음</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li class="paginate_button page-item next"><a class="page-link" href="?page=${pageBean.nextPage}&pageChange=true">다음</a></li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <c:import url="/WEB-INF/views/admin_include/footer.jsp"></c:import>
</div>
<script>
    function toggleSearch() {
        var searchForm = document.getElementById('searchForm');
        if (searchForm.style.display === 'none') {
            searchForm.style.display = 'block';
        } else {
            searchForm.style.display = 'none';
        }
    }
    function removeEmptyFields(event) {
        const inputs = document.querySelectorAll('#searchForm input, #searchForm select');
        inputs.forEach(input => {
            if (!input.value) {
                input.name = '';
            }
        });
    }
    function confirmDelete(userIdx) {
        if (confirm('정말 삭제하시겠습니까?')) {
            $.ajax({
                url: '${root}admin/userInfo/delete',
                type: 'POST',
                data: { id: userIdx },
                success: function(response) {
                    alert('삭제되었습니다.');
                    location.reload();
                },
                error: function() {
                    alert('삭제에 실패했습니다.');
                }
            });
        }
    }
</script>
</body>
</html>
