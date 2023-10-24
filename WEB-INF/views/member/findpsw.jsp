<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
</head>

	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<body>
	<%@ include file="../includes/header.jsp"%>
<br><br><br><br><br><br>
<div class="container">
	<form action="/resetpassword">
	<div class="mb-3">
    <label class="form-label">아이디</label>
    <input type="text" class="form-control" name = "id" id="id" placeholder="가입시 등록한 아이디를 적어주세요">
</div>
		<div class="mb-3">
			<label class="form-label">이메일</label>
		    <input type="email" class="form-control" name = "email" id="email" placeholder="가입시 등록한 이메일을 적어주세요">
		</div>
		<p id="errorMessage" style="color: red;"></p>
		<input type="button" class="btn btn-primary" id = "findPwBtn" value ="찾기">
		<p id="statusMessage"></p>
			<p id="sendingMessage" ></p>

		<div id = "confirm" style="display: none; margin-top: 50px; margin-bottom : 50px;">
			
			<input type="text" class="form-control"  id="checknum" placeholder="인증번호 입력하세요">
					<p id="numError" style="color: red;"></p>
			
			<input type="button" class="btn btn-primary" style="margin-top: 10px;"  id = "checkNum" value = "확인">
		</div>
		
		<div id="resetpsw" style="display: none;"  class="container" >
		<div class="mb-3">
    <label class="form-label">새로운 비밀번호</label>
    <input type="password" class="form-control" name="newpw" id="newpw">
    <p id="passwdError" class="error-message"></p>
</div>

<div class="mb-3">
    <label class="form-label">새로운 비밀번호 확인</label>
    <input type="password" class="form-control" name="newpwconfirm" id="newpwconfirm">
</div>
			<input type="button" class="btn btn-primary" id = "updateNewPw" value="비밀번호 수정하기" >
									<p id="passwdError" ></p>
		
		</div>
	</form>
</div>

<%@ include file="../includes/footer.jsp"%>

</body>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>


$(document).ready(function () {

    var passwordValidation = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{5,20}$/;

    $('#newpw').keyup(function() {
        var passwd = $(this).val();
        
        if (!passwordValidation.test(passwd)) {
            $("#passwdError").remove();
            $(this).css("border-color", "red");
            $(this).after('<span id="passwdError" style="color:red; font-size: 0.7em;">비밀번호: 5~20자의 영문 대/소문자, 숫자, 특수문자를 사용해 주세요.</span>');
        } else {
            $("#passwdError").remove();
            $(this).css("border-color", "");
        }
    });
    
    $('#newpw, #newpwconfirm').keyup(function() {
        var password = $("#newpw").val();
        var confirmPassword = $("#newpwconfirm").val();

        if (password != confirmPassword) {
            $("#passwordError").remove();
            $("#passwordSuccess").remove();
            $('#newpwconfirm').after('<span id="passwordError" style="color:red; font-size: 0.7em;">비밀번호가 일치하지 않습니다.</span>');
        } else if (password.length > 0 && confirmPassword.length > 0) {
            $("#passwordError").remove();
            $("#passwordSuccess").remove();
          	$('#newpwconfirm').after('<span id="passwordSuccess" style="color:green; font-size: 0.8em;">비밀번호가 일치합니다.</span>');
      	}
    });

	
    $("#updateNewPw").click(function(event) {
        event.preventDefault(); // 페이지 리로드 방지
        var id = $("#id").val();
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		var newPassword = $('#newpw').val(); 
		var newPasswordConfirm = $('#newpwconfirm').val();

		if(newPassword !== newPasswordConfirm){
			alert('입력한 두 개의 비밀번호가 일치하지 않습니다.');
			return;
		}

	    $.ajax({
	        url : '/member/resetPassword',
	        type : 'POST',
	        data: { "id": id, "newPassword": newPassword },
	         beforeSend: function(xhr) {
	                xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	            },
	        success:function(response){
		        alert('비밀번호가 성공적으로 변경되었습니다.');
	        	window.location.href = "/customLogin"; // 로그인 페이지로 이동

		    }, 
		    error:function(request, status, error){
		        alert('비밀번호 변경에 실패했습니다.');
		    }
	    });
	});
});


$("#checkNum").click(function(event) {
    event.preventDefault(); // 추가: form 태그의 기본 동작(페이지 제출) 막기

	var checknum = $("#checknum").val();
	var id = document.getElementById("id").value;

    var csrfHeaderName = "${_csrf.headerName}";
    var csrfTokenValue = "${_csrf.token}";

    $.ajax({
        url: '/member/checknum',
        type: 'POST',
        contentType: "application/json",
        data: JSON.stringify({ "id": id, "checknum": checknum }), // 'userId'는 실제 사용자 ID 값
        beforeSend: function(xhr) {
            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
        },
        success:function(response){
	        document.getElementById('numError').style.display='none';   // Hide the sending message
                alert("인증에 성공했습니다.");
                $('#resetpsw').css('display','block');
        }, 
        error:function(request, status, error){
            document.getElementById('numError').textContent = "인증번호가 올바르지 않습니다.";
        }
    });
});

$("#findPwBtn").click(function (event){
    event.preventDefault(); // 추가: form 태그의 기본 동작(페이지 제출) 막기

    var csrfHeaderName = "${_csrf.headerName}";
    var csrfTokenValue = "${_csrf.token}";
    var emailData = $("#email").val();
    var id = $("#id").val();


    $.ajax({
        url : '/member/checkUser',
        type : 'POST',
        data: { "id": id, "email": emailData },
         beforeSend: function(xhr) {
                xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
            },
        success:function(response){
	        document.getElementById('errorMessage').style.display='none';   // Hide the sending message

            document.getElementById('sendingMessage').textContent ="메일 전송중...";   // Show the sending message
            sendEmail(id, emailData);  // Call the sendEmail function
        }, 
        error:function(request, status, error){
            document.getElementById('errorMessage').textContent = "등록된 정보가 없습니다.";
        }
    });
});

function sendEmail(id, email) {
    event.preventDefault(); // 추가: form 태그의 기본 동작(페이지 제출) 막기

	 var csrfHeaderName = "${_csrf.headerName}";
	 var csrfTokenValue = "${_csrf.token}";

	$.ajax({
		url : '/member/findpsw',
		type : 'POST',
		data: { "id": id, "email": email },
		 beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
		success:function(response){
				alert("인증메일이 전송되었습니다.");
		        document.getElementById('sendingMessage').style.display='none';   // Hide the sending message

				$('#confirm').css('display','block');
	    }, 
	    error:function(request, status, error){
	        document.getElementById('errorMessage').textContent ="인증메일 전송에 실패했습니다.";
	    }
   });
}
</script>
</html>