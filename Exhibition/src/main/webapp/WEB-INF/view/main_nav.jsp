<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
 @font-face {
    font-family: 'GangwonEdu_OTFBoldA';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2201-2@1.0/GangwonEdu_OTFBoldA.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
*{font-family: 'GangwonEdu_OTFBoldA', sans-serif;} 
</style>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
	<div class="container-md" style="display: flex; justify-content:center; align-items: center;">
		<div class="navbar-header">
			<a class="navbar-brand" style="margin-right: 55px; font-size: 28px" href="<c:url value="/"/>">전국 문화행사</a>
			<a class="navbar-brand" style="margin-right: 55px; font-size: 28px" href="<c:url value="/area"/>">지역별 문화행사</a>
			<a class="navbar-brand" style="margin-right: 55px; font-size: 28px" href="<c:url value="/board"/>">리뷰 모음</a>
		</div>
	</div>
</nav>