<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
.btn{ background: linear-gradient(to right, #F7A4A4, #FEA679); color: #fff; }
</style>

<script type="text/javascript">
	function checkForm() {
		if (!document.Member.id.value) {
		    $('#myModal .modal-title').text('아이디를 입력하세요.');
		    $('#myModal').modal('show');
		    return false;
		}
		
		if (!document.Member.password.value) {
			$('#myModal .modal-title').text('비밀번호를 입력하세요.');
		    $('#myModal').modal('show');
		    return false;
		}
		return true;
	}
	$(document).ready(function() {
		
	    $('#loginform').submit(function(e) {
	        e.preventDefault(); // 폼 제출 이벤트 막기
	        if (checkForm()) { // checkForm 함수가 true를 반환하면 Ajax 요청을 보냄
	            $.ajax({
	                url: '${pageContext.request.contextPath}/processLoginMember',
	                type: 'POST',
	                data: $('#loginform').serialize(),
	                success: function(data) {
	                    $('#success').modal('show'); // 모달창 띄우기
	                },
	                error: function(jqXHR, textStatus, errorThrown) {
	                    var errorMessage = JSON.parse(jqXHR.responseText).message; // 서버에서 반환한 오류 메시지 가져오기
	                    $('#failure .modal-body').text(errorMessage); // 모달창에 오류 메시지 표시
	                    $('#failure').modal('show'); // 로그인 실패 시 모달창 띄우기
	                    
	                    
	                }
	            });
	        }
	    });
	});



</script>

<title>Login</title>
</head>
<body>
	
		<%@include file="../login_nav.jsp" %>	 
		<%@include file="../main_nav.jsp" %>	
		
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
		        <h4 class="modal-title" id="myModalLabel">환영합니다</h4>
		      </div>
		        <button type="button" class="btn" data-dismiss="modal" onclick="location.href='${pageContext.request.contextPath}/'">확인</button>
		    </div>
		  </div>
		</div>
		
		<div class="container" style="width: 400px; margin-top: 10px" align="left">	
			
			<form name="Member" id="loginform" action="${pageContext.request.contextPath}/processLoginMember" method="post" onsubmit="return checkForm()">
				
				<div class="input-group mb-3">
					<label class="input-group-text">User ID</label> 
					<input  name="id" type="text" class="form-control" placeholder="ID">
				</div>	
					<div class="input-group mb-3">
					<label class="input-group-text">Password</label>
					<input type="password" class="form-control" name="password" placeholder="PW">
				</div>
				
				<div class="d-grid gap-2 col-6 mx-auto">
				<button type="submit" class="btn" id="loginbtn">Login</button>
				</div>	
					
			</form>
			
		</div>	
		

	
		<%@include file="../footer.jsp" %>

</body>
</html>