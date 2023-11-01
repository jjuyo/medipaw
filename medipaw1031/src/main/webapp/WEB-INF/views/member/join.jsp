<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>회원가입</title>
        <link href="https://fonts.googleapis.com/css2?family=Gaegu:wght@300;400;700&display=swap" rel="stylesheet">
    
    <style>
    select {
    border: 1px solid #ccc;
    padding: 5px;
    font-size: 10px;
    border-radius: 5px;
}
    body {
            background-color: #87CEFA; /* 하늘색 배경 */
            font-family: 'Gaegu', cursive;
        }


#title-line {
    border-top: 2px solid #87CEFA; /* 하늘색 선 */
    position: relative;
    margin: 50px 0; /* 선 위아래로 마진 추가 */
}

#signup-box {
    width: 200px; /* 사각형 너비 */
    height: 50px; /* 사각형 높이 */
    background-color: #87CEFA; /* 사각형 배경색 하늘색으로 설정 */
    color: white; /* 글자색 흰색으로 설정 */
    
    position: absolute;
    top: -25px; /* 상위 요소(선) 중앙에 위치하도록 설정 */ 
    left: calc(50% - 100px); /* 화면 가운데에 위치하도록 설정 */

    display:flex;
	justify-content:center;
	align-items:center;

	border-radius : 10%;
}
       
       
.container {
    max-width: 960px; /* 컨테이너의 최대 너비 설정 */
}

        .form-control {
            border-radius: 50px; /* 입력 필드를 동그랗게 */
        }

        .btn {
            border-radius: 50px; /* 버튼을 동그랗게 */
        }

   
        
       .form-horizontal{
           padding : 20px;
           background : white;
           border-radius : 30px;
           box-shadow : 0px 0px 10px gray;
       }
       
       input[type="text"], input[type="password"], input[type="tel"], input[type="date"]{
           border-radius : 30px !important;
       }
       
       select{
          border-radius : 30px !important;
          appearance:none;
          -webkit-appearance:none;/*크롬*/
          -moz-appearance:none;/*파이어폭스*/
          background:url('http://www.familylovedproducts.com/wp-content/uploads/2018/02/white-arrow-204-2048179.png') no-repeat scroll right center transparent;/*화살표 이미지*/
          padding-right:25px;/*화살표 이미지 크기에 따라 조절하세요.*/
      }
      
      ::placeholder { 
         color:#BDBDBD !important ;
         opacity:1 !important ; 
      }
div {
   margin-bottom: 10px;
   padding: 1px;
}



.divC {
   display: flex;
   justify-content: center;
   align-items: center;
}


 /* The Modal (background) */
.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  padding-top: 100px; /* Location of the box */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
}

/* Modal Content (box) */
.modal-content {
   margin : auto;
   padding :20px;
   border :1px solid #888;
   width :50%;
}
        }
</style>
    
</head>
   <%@ include file="../includes/header.jsp"%>

<!-- <body>
회원가입 페이지
<div><label> 아이디 : <input type="text" name="id"/> </label></div>
<div><label> 비밀번호 : <input type="password" name="passwd"/> </label></div>
<div><label> 이름 : <input type="name" name="name"/> </label></div>
<div>
        <input type="radio" name="role" value="ROLE_MEMBER">
        <label for="email">유저</label>
 
        <input type="radio" name="role" value="ROLE_ADMIN">
        <label for="phone">관리자</label>
 
        <input type="radio" name="role" value="ROLE_HOSPITAL">
        <label for="mail">병원 관계자</label>
    </div>
<button id="join">join</button>



<body>  -->

<body>
   <br>
   <br>
   <br>
     <br>
   <br>
   <br>


<div id="title-line">
   <div id="signup-box">
       <h2>회원가입</h2>
   </div>
</div>
   <br>

   <main role="main">
      <div class="container divC">
         <form class="form-horizontal">
         <input type="hidden" name="${_csrf.parameterName }"   value="${_csrf.token }"><!-- 서버에서 들어오는 정보 -->
         

            <div class="head">[ 필수 ]</div>
            
            
      <div>
        <input type="radio" name="role" value="ROLE_MEMBER" checked>
        <label for="email">유저</label>
 
 <!--        <input type="radio" name="role" value="ROLE_ADMIN">
        <label for="phone">관리자</label>
 
        <input type="radio" name="role" value="ROLE_HOSPITAL">
        <label for="mail">병원 관계자</label> -->
    	</div>
            <div class="form-group row">
               <label class="col-sm-3">이름</label>
               <div class="col-sm-5">
                  <input type="text" class="form-control" name="name"
                     id="name" required 
                     >
               </div>
            </div>

            <div class="form-group row">
               <label class="col-sm-3">아이디</label>
               <div class="col-sm-5">
                  <input type="text" class="form-control" name="id" id="id"
                     required readonly >
               </div>
                <div class="col-sm-3">
                  <input type="button" class="btn btn-outline-secondary" value="중복 확인"
                     id="idCheckBtn">
               </div>
        
            </div>
<!-- 아이디 중복체크 모달 -->
<div id="idCheckModal" class="modal">
    <div class="modal-content" style="width: 25%;">
        <p id="msg"></p>
        <input type="text" id="checkId" placeholder="아이디를 입력해주세요">
        <div style="display: flex; justify-content: center; align-items: center;">
            <input class="btn amado-btn close1" type="button" value ="사용하기"
                style= "width: 50%; margin:auto;" id= "useId"> 
            <input class="btn amado-btn close1" type="button" value ="닫기"
                style= "width: 50%; margin:auto;" id= "close"> 
        </div>
    </div>
</div>


      
            <div class="form-group row">
               <label class="col-sm-3">비밀번호</label>
               <div class="col-sm-5">
                  <input type="password" class="form-control" name="passwd"
                     id="passwd" required >
               </div>
            </div>

            <div class="form-group row">
               <label class="col-sm-3">비밀번호 확인</label>
               <div class="col-sm-5">
                  <input type="password" class="form-control" name="pwchk"
                     id="pwchk" required >
               </div>
            </div>

           <div class="form-group row">
               <label class="col-sm-3"> 주소</label>
               <div class="col-sm-5">
                  <input type="text" name="addr1" id="addr1"
                     class="form-control" required>
               </div>
            </div>

            <div class="form-group row">
               <label class="col-sm-3">전화번호</label>
               <div class="col-sm-5">
                  <input type="tel" class="form-control" name="phone"
                     id="phone" required >
               </div>
            </div>

            <div class="form-group row">
               <label class="col-sm-3">이메일</label>
               <div class="col-sm-2">
                  <input type="text" class="form-control" name="email1" id="email1">
               </div>
               @
               <div class="col-sm-3">
                  <input type="text" class="form-control" name="email2" id="email2">
               </div>
               <div class="col-sm-3">
                  <select id="email3">
                     <option value="self">직접 입력</option>
                     <option value="gmail.com">gmail.com</option>
                     <option value="naver.com">naver.com</option>
                  </select>
               </div>
            </div>

            <div class="head" style="">[ 선택 ]</div>

            <div class="form-group row">
               <label class="col-sm-3">생년월일</label>
               <div class="col-sm-5">
                  <input type="date" class="form-control" name="birth"
                     id="birth" min="1900-01-01" max="2030-12-31">
               </div>
            </div>



            <div style="display: flex; justify-content: center; align-items: center;">
   
               <input type="button" class="btn btn-secondary" onclick="history.back()" value="취소">
               &nbsp;&nbsp;&nbsp;&nbsp;
               <input type="button" class="btn btn-outline-secondary" id='join' value="join">
               
   	</div>
   	</form>
   	</div>
   </main>

   <br>
   <br>
   <br>

   <%@ include file="../includes/footer.jsp"%>
 

</body>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
$(document).ready(function() {
    // 생년월일이 변경될 때 이벤트를 처리할 수 있으나 추가적인 코드가 필요합니다.
    
    
    
    $('#email3').change(function() {
        var selected = $(this).val();
        if (selected === 'self') {
            $('#email2').val('');
            $('#email2').prop('readonly', false);
        } else {
            $('#email2').val(selected);
            $('#email2').prop('readonly', true);
        }
    });
    
    var passwordValidation = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{5,20}$/;

    $('#passwd').keyup(function() {
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
    
     $('#passwd, #pwchk').keyup(function() {
        var password = $("#passwd").val();
        var confirmPassword = $("#pwchk").val();

        if (password != confirmPassword) {
            $("#pwchk").css("border-color", "red");
            $("#passwordError").remove();
            $("#passwordSuccess").remove();
            $("#pwchk").after('<span id="passwordError" style="color:red; font-size: 0.7em;">비밀번호가 일치하지 않습니다.</span>');
        } else if (password.length > 0 && confirmPassword.length > 0) {
            $("#pwchk").css("border-color", "");
            $("#passwordError").remove();
            $("#passwordSuccess").remove();
            $("#pwchk").after('<span id="passwordSuccess" style="color:green; font-size: 0.8em;">비밀번호가 일치합니다.</span>');
        }
    }); 
    

});


var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";


$("#join").click(function (event){
    event.preventDefault(); // 추가: form 태그의 기본 동작(페이지 제출) 막기
    var passwordValidation = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{5,20}$/;

    var id = $('input[name=id]').val();
    var name = $('input[name=name]').val();
    var role = $("input[type=radio][name=role]:checked").val();

    // Get the values of other fields
    var addr1 = $('#addr1').val();
    var phone = $('#phone').val();
    var email1 = $('#email1').val();
	var email2 = $('#email2').val();  
	var birth=$('#birth').val();
    var passwd = $('#passwd').val();
    var pwchk = $('#pwchk').val();

	if (!id ) {

	        alert("모든 필수 항목을 입력해주세요.");
	        return;
		}
    
    // 비밀번호와 비밀번호 확인이 일치하는지 검사
    if (passwd !== pwchk) {
        alert("비밀번호가 일치하지 않습니다.");
        return;
    }
    
    // 비밀번호 유효성 검사 통과 여부 확인
    if (!passwordValidation.test(passwd)) {
        // 애니메이션: 배경색을 빨간색으로 변경 후 원래대로 돌아오게 함
        $("#passwd").animate({
            backgroundColor: "#ff0000"
        }, 500 ).animate({
            backgroundColor: "#ffffff"
        }, 500 );
        
        alert("비밀번호가 유효하지 않습니다.");
        
        return;
     }

	// Check if all required fields are filled
	if (!role || !addr1 || 
		 !phone || !email1 || !email2) {
        alert("모든 필수 항목을 입력해주세요.");
        return;
	}
	
	// Check if birth date is empty, if it is, set it to null
var birthInput=$('#birth');
var birth=birthInput.val() ? birthInput.val() : '';
	$.ajax({
        type : 'post',
        url : '/member/join', // URL 변경: 컨트롤러에서 설정한 URL과 동일하게 수정
        dataType : 'text',
        data : JSON.stringify({
            "id": id,
            "passwd": passwd, // 'pw' 대신 'passwd' 사용
            "name": name,
            "role": role,
            //"postnum" : postnum, // HTML form에 해당 필드가 없으므로 주석 처리
            "addr1" : addr1,
            "phone" : phone,
			"email" : email1 + "@" + email2, 
			//"email": email // If you want to send it as a single field
			"birth" : birth
        }),
        
        beforeSend: function(xhr) {
            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
        },
        contentType: 'application/json; charset=utf-8',

    	success: function(result) {
        	console.log("success");
        	alert("회원가입이 성공적으로 완료되었습니다."); // 회원가입 성공 알림창
        	window.location.href = "/customLogin"; // 로그인 페이지로 이동
    	},
    	error: function(xhr, status, error) {
    		console.log(error);
    		alert("회원가입에 실패하였습니다. 다시 시도해주세요."); // 회원가입 실패 알림창
    	}

		
   });
});
</script>
<script>
$(document).ready(function() {
	  // ...
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";
	  var modal = document.getElementById('idCheckModal');
	  var checkBtn = document.getElementById('idCheckBtn');
	  var closeBtn = document.getElementById('close');
	  var useIdButton = document.getElementById('useId');

	  checkBtn.onclick = function() {
	    modal.style.display = 'block';
	    
	    var idInput = $('#checkId');
	    var msgElement = $('#msg');

	    idInput.on('input', function() {
	      // ID 유효성 검사
	      if (!/^[a-zA-Z0-9]+$/.test(idInput.val())) {  
	    	  msgElement.html('아이디는 영문자와 숫자의 조합으로만 가능합니다.');
	    	  msgElement.addClass('error-message');
	    	  useIdButton.disabled=true;
	          return;
	      } else if (idInput.val().length > 20 || idInput.val().length < 5) {  
	    	  msgElement.html('아이디는 최소 5자, 최대 20자로 입력해주세요.');
	    	  msgElement.addClass('error-message');
	          useIdButton.disabled=true;
	          return;
	      } else {
	    	  
	    	  $.ajax({
	    		  url : '/member/checkDuplication',
	    		  method : 'POST',
	    		  data : {"id": idInput.val()},
	    		  contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
	    		  beforeSend: function(xhr) {
	    		      xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	    		  },
	    		    success : function(response) {
	    		    	msgElement.text('이미 사용중인 아이디 입니다.');
	    		    	useIdButton.disabled=true;
	    		    	 },
	    		    error : function(request, status, error) {
	    		    	msgElement.text('사용 가능한 아이디 입니다.');
    		            useIdButton.disabled=false; // Only enable the button when the ID is valid and not duplicated.
	    		    }
	        });
	      }
	    });

	    useIdButton.onclick = function() {

	       // Set the new ID value to the original input field
	       $('#id').val(idInput.val());
	      
	       // Close the modal
	       modal.style.display = 'none';
	       
	       // Show success message or perform other actions
	     };
	    
	     closeBtn.onclick=function(){
	         modal.style.display ='none';
	         idInput.val('');
	         msgElement.text('');
	     };
	     
	     window.onclick=function(event){
	         if(event.target==modal){
	             modal.style.display ='none';
	             idInput.val('');
	             msgElement.text('');
	         }
	     };
	     
	     event.preventDefault();
	   };

	});
</script>
</html>