<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<html>
<head>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
.btn{ background: linear-gradient(to right, #F7A4A4, #FEA679); color: #fff; }
</style>
	
<title>회원 수정</title>
<script type="text/javascript">

	function checkForm() {
		
		if (document.deleteMember.password.value != document.deleteMember.password_confirm.value) {
			$('#myModal .modal-title').text('비밀번호를 동일하게 입력하세요.');
		    $('#myModal').modal('show');
		    return false;
		}	
		
		return true;
	}
	
	$(document).ready(function() {
	    $('#deleteMember').submit(function(e) {
	        e.preventDefault(); // 폼 제출 이벤트 막기
	        if (checkForm()) { // checkForm 함수가 true를 반환하면 Ajax 요청을 보냄
	            $.ajax({
	                url: '${pageContext.request.contextPath}/processDeleteMember',
	                type: 'POST',
	                data: $('#deleteMember').serialize(),
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
</head>
<body>
		
	<%@include file="../login_nav.jsp" %>	
	<%@include file="../main_nav.jsp" %>	
	
	<c:if test="${not empty errorMessage}">
		<p>${errorMessage}</p>
	</c:if>
	
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title" id="myModalLabel">환영합니다</h4>
	      </div>
	        <button type="button" class="btn" style="color: white;" data-dismiss="modal">확인</button>
	    </div>
	  </div>
	</div>

	<div class="modal fade" id="success" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title" id="myModalLabel">회원정보 탈퇴가 완료되었습니다.</h4>
	      </div>
	        <button type="button" class="btn" data-dismiss="modal" onclick="location.href='${pageContext.request.contextPath}/'">확인</button>
	    </div>
	  </div>
	</div>
	
	<div class="container" style="width: 400px; margin-top: 10px" align="left">
	<form name="deleteMember" id="deleteMember" class="form-horizontal" action="${pageContext.request.contextPath}/processDeleteMember"  method="post" onsubmit="return checkForm()">
			
			<div class="input-group mb-3">
				<label class="input-group-text"> 회원 ID </label>
				<input name="id" type="text" class="form-control" placeholder="id" value="<c:out value='${sessionScope.loginUser.id}'/>" />
			</div>
			
			<div class="input-group mb-3">
				<label class="input-group-text"> 회원 Password  </label>
				<input type="text" name="password" class="form-control" value="<c:out value='${sessionScope.loginUser.password}'/>" >
			</div>
			
			<div class="input-group mb-3">
				<label class="input-group-text"> Password 확인  </label>
					<input name="password_confirm" type="text" class="form-control" placeholder="password_confirm" >
			</div>
			
			<div class="input-group mb-3">
				<label class="input-group-text"> 현재 닉네임 </label>
					<input class="form-control" value="<c:out value='${sessionScope.loginUser.nickname}'/>" >
			</div>
			
			
			<div class="input-group mb-3">
				<label class="input-group-text"> 현재 이메일 </label>
					<input name="email" type="text" class="form-control"
					 value="<c:out value='${sessionScope.loginUser.email}'/>" >
			</div>
			
			<div class="form-group  row" style="margin-top: 10px">
				<div class="col-sm-offset-2 col-sm-10 ">
					<button type="submit" class="btn" style="color: white;">회원탈퇴</button>
				</div>
			</div>
	</form>
	</div>
	
	
	<%@include file="../footer.jsp" %>

</body>
</html>
