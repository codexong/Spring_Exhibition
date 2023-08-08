<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Arrays"%>
<%@ page import="com.example.domain.BoardDTO" %>
<%@ page import="com.example.domain.BuyDTO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
      
   <h1>게시판 목록</h1>
 
<div style="padding: 50px; flex: 2;">
  <table class="table table-hover">
    <c:forEach var="buy" items="${buyDTO}">
      <c:set var="nickname" value="" />
      <c:set var="text" value="" />
      <c:set var="grade" value="" />
      <c:forEach var="board" items="${BoardDTO}">
        <c:if test="${board.title == buy.title}">
          <c:set var="nickname" value="${board.nickname}" />
          <c:set var="text" value="${board.text}" />
          <c:set var="grade" value="${board.grade}" />
        </c:if>
      </c:forEach>
      <c:if test="${not empty text}">
        <tr class="buy-title" data-title="${buy.title}">
          <td style="width: 200px;">
            <img src="${buy.thumbnail}" style="max-width: 100%; height: auto;">
          </td>
          <td>
            <strong>${buy.title}</strong></td>
           <tr>
           <td>작성자 : ${nickname}</td>
           <td>내용 : ${text}</td>
          <td>평점 :  ${grade}</td>
          </tr>
        </tr>
      </c:if>
    </c:forEach>
  </table>
</div>


<script>
  $(document).ready(function() {
    var prevTitle = "";
    $('.buy-title').each(function() {
      var currentTitle = $(this).data('title');
      if (prevTitle === currentTitle) {
        $(this).remove();
      } else {
        prevTitle = currentTitle;
      }
    });
  });
</script>

   <%@ include file="../footer.jsp" %>

</body>
</html>