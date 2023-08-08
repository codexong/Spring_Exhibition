<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Arrays"%>

<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
@font-face {
    font-family: 'GangwonEdu_OTFBoldA';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2201-2@1.0/GangwonEdu_OTFBoldA.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

 *{font-family: 'GangwonEdu_OTFBoldA', sans-serif;}
</style>
<meta charset="UTF-8">
<title>Exhibition Info</title>
   
</head>
<body>
   	<%@ include file="../login_nav.jsp" %>

 	<%@ include file="../main_nav.jsp" %>
 	
 	<h1 class="text-center">리뷰 수정</h1>
 	
	<form action="${pageContext.request.contextPath}/board/update" method="post">
	
	<label for="number">게시물 번호</label>
	<input type="number" class="form-control" id="num" name="num" value="${board.num}">
	
    <div class="form-group">
        <label for="title">제목</label>
        <input type="text" class="form-control" id="title" name="title" value="${board.title}" placeholder="제목을 입력하세요." required>
    </div>

    <div class="form-group">
        <label for="nickname">작성자</label>
        <input type="text" name="nickname" value="${sessionScope.loginUser.nickname}" id="nickname" readonly="readonly" required>
    </div>

    <div class="form-group">
        <label for="text">내용</label>
        <textarea class="form-control" id="text" name="text" rows="5" placeholder="내용을 입력하세요." required>${board.text}</textarea>
    </div>

    <div class="form-group">
        <label for="grade">평점</label>
        <input type="text" class="form-control" id="grade" name="grade" min="1" max="5" step="1" value="${board.grade}" required>
    </div>
	
	<button type="submit" class="btn btn-primary">수정 완료</button>
	<button type="submit" class="btn btn-danger" formaction="${pageContext.request.contextPath}/board/delete/${board.num}">게시글 삭제</button>
	
</form>
	<br>
	<a href="${pageContext.request.contextPath}/board">목록으로</a>



   	<%@ include file="../footer.jsp" %>
</body>
</html>