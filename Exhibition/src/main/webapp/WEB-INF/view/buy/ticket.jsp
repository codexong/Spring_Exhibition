<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
    @font-face {
        font-family: 'GangwonEdu_OTFBoldA';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2201-2@1.0/GangwonEdu_OTFBoldA.woff') format('woff');
        font-weight: normal;
        font-style: normal;
    }
    
    * {
        font-family: 'GangwonEdu_OTFBoldA', sans-serif;
    }
    
    .card {
        background-color: #fff;
        border-radius: 10px;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        padding: 20px;
        width: 400px;
        margin: 50px auto;
        text-align: center;
    }
    
    .card h1 {
        margin-top: 0;
    }
    
    .card p {
        margin: 10px 0;
    }
    
    .card .button {
        display: inline-block;
        padding: 10px 20px;
        border-radius: 5px;
        background: linear-gradient(to right, #F7A4A4, #FEA679);
        color: #fff;
        text-decoration: none;
        margin-top: 20px;
        transition: background 0.3s;
    }
    
    .card .button:hover {
        background: #F7A4A4;
    }
</style>

<meta charset="UTF-8">
<title>티켓 발급</title>
</head>
<body>
<%@include file="../login_nav.jsp" %>   
<%@include file="../main_nav.jsp" %>   

<div class="card">
    <h1>티켓 발급 페이지</h1>
    <p>티켓 발급이 완료되었습니다!</p>
    <img src="https://blog.kakaocdn.net/dn/bqqWTy/btqDQtYuJua/X1KNO1U3u3kzWQBunWOVCK/img.jpg">
    
 	<c:forEach var="buyDTO" items="${buyDTO}">
	
	<p> 구매자 아이디 : ${buyDTO.id}</p><br>
	<p> 구매 전시회 : ${buyDTO.title}</p><br>
	<p> 성인 티켓 수량 : ${buyDTO.adult}</p><br>
	<p> 아동 티켓 수량 : ${buyDTO.child}</p><br>
	
	</c:forEach>

    <a href="${pageContext.request.contextPath}/mybuy" class="button">확인</a>
</div>

         
</body>
</html>