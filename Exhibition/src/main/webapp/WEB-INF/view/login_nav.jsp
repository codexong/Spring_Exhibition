<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
#link {text-decoration: none;}
.navbar { background: linear-gradient(to right, #F7A4A4, #FEA679);}
  .navbar-light .navbar-text { color: #fff;}
  .navbar-light .navbar-brand { color: #fff;}
 @font-face {
    font-family: 'GangwonEdu_OTFBoldA';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2201-2@1.0/GangwonEdu_OTFBoldA.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
*{font-family: 'GangwonEdu_OTFBoldA', sans-serif;} 
</style>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container">
    <a class="navbar-brand" href="<c:url value="/"/>"> 
      <img src="<%=request.getContextPath()%>/resources/imges/LOGO.png" width="55" height="50" style="display:inline-block; margin-bottom: 8px;">
      <h1 class="navbar-text" style="display:inline-block;">문화 행사 플랫폼</h1>
    </a>
  </div>
	<div class="container-md" style="display: flex; justify-content: flex-end; align-items: center;">
		<c:choose>
			<c:when test="${empty loginUser}">
				<a class="navbar-brand" style="margin-right: 30px" href="<c:url value='/login'/>">로그인 </a>
				<a class="navbar-brand" href='<c:url value="/addMember"/>'>회원 가입</a>
			</c:when>
			<c:otherwise>
				<a class="navbar-brand">[${sessionScope.loginUser.nickname}님]</a>
				<a class="navbar-brand" href="<c:url value="/mybuy"/>">내 활동</a>
				<a class="navbar-brand" href="<c:url value="/logout"/>">로그아웃 </a>
				<a class="navbar-brand" href="<c:url value="/updateMember"/>">회원 수정</a>
			</c:otherwise>
		</c:choose>
	</div>
</nav>
