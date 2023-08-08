<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Arrays"%>
<%@ page import="com.example.service.BuyService" %>

<!DOCTYPE html>
<html>
<head>
<%
	String title = request.getParameter("title");
	String thumbnail = request.getParameter("thumbnail");
%>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style type="text/css">
@font-face {
	font-family: 'GangwonEdu_OTFBoldA';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2201-2@1.0/GangwonEdu_OTFBoldA.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

* {
	font-family: 'GangwonEdu_OTFBoldA', sans-serif;
}

.btn {
	background: linear-gradient(to right, #F7A4A4, #FEA679);
}
</style>

<script type="text/javascript">
	
	function checkForm() {
		  if (document.buypage.adult.value == '성인 티켓 수량 선택') {
		      $('#myModal .modal-title').text('성인 티켓 수량을 선택하세요');
		      $('#myModal').modal('show');
		      return false;
		    }
		
		if (document.buypage.child.value == '아동 티켓 수량 선택') {
			$('#myModal .modal-title').text('아동 티켓 수량을 선택하세요');
		    $('#myModal').modal('show');
		    return false;
		}	
		
		return true;
	}
	
	$(document).ready(function() {
	    $('#buyForm').submit(function(e) {
	        e.preventDefault(); // 폼 제출 이벤트 막기
	        if (checkForm()) { // checkForm 함수가 true를 반환하면 Ajax 요청을 보냄
	            $.ajax({
	                url: '${pageContext.request.contextPath}/processBuy',
	                type: 'POST',
	                data: $('#buyForm').serialize(),
	                success: function(data) {
	                    $('#success').modal('show'); // 모달창 띄우기
	                },
	                error: function(jqXHR, textStatus, errorThrown) {
	                    // 오류 처리
	                }
	            });
	        }
	    });
	});
	
</script>

<meta charset="UTF-8">
<title>Exhibition Info</title>
</head>
<body>


	<%@include file="../login_nav.jsp"%>
	<%@include file="../main_nav.jsp"%>
	
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title" id="myModalLabel"></h4>
	      </div>
	        <button type="button" class="btn" style="color: white;" data-dismiss="modal">확인</button>
	    </div>
	  </div>
	</div>
	
	<div class="modal fade" id="success" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h4 class="modal-title" id="myModalLabel">티켓 구매가 완료되었습니다.</h4>
		      </div>
		      <button type="button" class="btn" data-dismiss="modal" onclick="location.href='${pageContext.request.contextPath}/buyticket'"> 구매 티켓 확인 </button>
		    </div>
		  </div>s
		</div>
		

	<div class="container mt-4">


		<h1 style="text-align: center;">구매하기</h1>


		<div class="row justify-content-center align-items-center">
			<div class="card" style="width: 18rem;">
				<img class="card-img-top" src="<%= request.getParameter("thumbnail") %>">
			</div>

			<div class="col-md-3">
				<div class="row">
					<div class="col">
						<div class="card" style="width: 18rem;">
							<div class="card-body">
								<h5 class="card-title"><%= request.getParameter("title") %></h5>
							</div>
						</div>
					</div>
				</div>

				<form class="form-horizontal" action="${pageContext.request.contextPath}/processBuy" name="buypage" onsubmit="return checkForm()"
					method="post" id="buyForm">
					
					<div class="row mt-4">
						<div class="col">
							<div class="card" style="width: 18rem;">
								<div class="card-body">
									<input type="hidden" name="thumbnail" value="<%=thumbnail%>">
									<input type="hidden" name="title" value="<%=title%>">
									<h3 class="card-title">티켓 수량 선택</h3>
									<h5 class="card-text">성인</h5>
									<select name="adult" class="form-control"
										style="height: 40px; font-size: 20px;">
										<option>성인 티켓 수량 선택</option>
										<option>0</option>
										<option>1</option>
										<option>2</option>
										<option>3</option>
									</select>
									<h5 class="card-text" style="margin-top: 5px;">아동</h5>
									<select name="child" class="form-control"
										style="height: 40px; font-size: 20px;">
										<option>아동 티켓 수량 선택</option>
										<option>0</option>
										<option>1</option>
										<option>2</option>
										<option>3</option>
									</select><br>
									<button type="submit" class="btn" style="color: white;">구매하기</button>
									<button type="reset" class="btn" style="color: white;" onclick="reset()">취소</button>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>

</body>
</html>
