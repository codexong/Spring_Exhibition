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
	
	<h1 style="text-align: center;"><%= request.getParameter("title") %> 리뷰 </h1>
	
	<div style="display: flex;">
	
	 
	 <div class="card" style="width: 18rem;  margin-left: 300px;">
	  <img class="card-img-top" src="${param.thumbnail}">
	 </div>
	 
	 
	  <div style="padding: 50px; flex: 2;">
	    <table class="table table-hover">
	      <tr>
	      <th>게시물 번호</th>
	        <th>작성자</th>
	        <th>리뷰내용</th>
	        <th>평점</th>
	        
	      </tr>
	      <c:forEach var="BoardDTO" items="${BoardDTO}">
	        <tr>
	          <td>${BoardDTO.num}</td>
	          <td>${BoardDTO.nickname}</td>
	          <td>${BoardDTO.text}</td>
	          <td>${BoardDTO.grade}</td>
	         <c:if test="${BoardDTO.nickname eq sessionScope.loginUser.nickname}">
				<td><a href="${pageContext.request.contextPath}/board/update/${BoardDTO.num}">리뷰수정</a></td>
			</c:if>


	        </tr>
	      </c:forEach>
	    </table>
	  </div>
	</div>


</body>
</html>