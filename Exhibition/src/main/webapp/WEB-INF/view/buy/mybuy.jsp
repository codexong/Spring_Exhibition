<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">

<title>내 활동</title>
</head>
<body>

	<%@include file="../login_nav.jsp"%>
	<%@include file="../main_nav.jsp"%>
	
	<div class="container mt-4">
	<h1 style="text-align: center;">${sessionScope.loginUser.name}님 구매내역</h1>
	</div>

	<div style="padding: 50px">
		<table class="table table-hover">
			<tr>
				<th>구매 전시</th>
				<th>성인 티켓</th>
				<th>아동 티켓</th>
				<th>입장권 확인</th>
				<th>리뷰 작성</th>
			</tr>

			<c:forEach var="buyDTO" items="${buyDTO}">

				<tr>
					<td>${buyDTO.title}</td>
					<td>${buyDTO.adult}</td>
					<td>${buyDTO.child}</td>
					<td><a href="${pageContext.request.contextPath}/ticket?num=${buyDTO.num}">입장권</a></td>
					<td><a href="${pageContext.request.contextPath}/board/write?num=${buyDTO.num}">리뷰작성</a></td>	
				</tr>
			</c:forEach>
		</table>
	</div>


</body>
</html>