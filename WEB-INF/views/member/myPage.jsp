<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html>
<html>
<head>
<link rel= "stylesheet" href= "https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<title>My Page</title>
    <style>
    
    .modal-header .modal-title {
    float: left;
}

.modal-header .close {
    float: right;
}
       body {
    display: flex;
    flex-direction: column; 
    margin: 0;
    padding: 0;
    font-family: Arial, sans-serif;
}

.main-content {
   /* ... 기존 스타일 ... */
   height: calc(100vh - 60px); /* 예시로 헤더와 푸터 높이가 각각 30px라고 가정 */
}

.footer {
   /* ... 기존 스타일 ... */
   height: 30px; /* 예시로 푸터 높이가 30px라고 가정 */
}
             .menu {
            width: 200px;
            height: 100vh;
            background-color: 		#B0C4DE		;
            padding-top: 20px;
        }
        .menu a {
            display: block;
            text-decoration: none;
            color:black; 
	    transition-duration :1s ;
	    padding-left :10px ;
        }
	.menu a:hover{
	    transform :scale(1.1) ;
	}
        .content {
            flex-grow: 1;
            padding: 20px;
            color: black;
            transition-duration: 1s;
        }
      
        .mcontent {
            display: flex;
            width: 100%; /* 전체 너비 사용 */
        }
        .mcontent .menu,
        .mcontent .content {
            height: 100vh; /* 화면 전체 높이 사용 */
        }
        .footer {
            background-color: #333;
            color: white;
            text-align: center;
            padding: 10px;
        }
        .content h1 {
            border-bottom: 1px solid #D3D3D3; /* 연한 회색 선 */
            padding-bottom: 10px;
        }

        .info-block {
            background-color: #f9f9f9;
            border-radius: 5px;
            margin-bottom: 10px;
            padding: 10px; 
        }

        .info-item {
           border-radius: 5px;
           background-color:#E6E6FA ;
           margin-bottom :5px ;
           padding :10px ;
        }

       .edit-button {
          display:inline-block;
          text-align:center;
          background-color:#B0C4DE; /* Green */
          color:white;
          text-decoration:none;
          padding :7.5px ;
	  float:right ; 
	  margin :7.5px ; 
	  border:none ; /* 테두리 제거 */
	  border-radius :7.5px ; /* 동그랗게 */
       }
       
       .edit-button:hover{
         background-color:#2F4F4F ;
       }

	#pageMenu{
	   display:block ;
	   text-align:center ; 
	   background-color:#B0C4DE ;  
	   color:black ;  
	   text-decoration:none ;  
	   width :80% ;
	   border:none ; /* 테두리 제거 */
	}

	#pageMenu:hover{
	    transform :scale(1.1) ;
	    transition-duration:0.25s ;

	}
    </style>
    
    
</head>
<body>
    <%@ include file="../includes/header.jsp"%>
    <div class="mcontent">
        <div class="menu">
        <br><br><br><br><br>
        <a href="/member/myPage"><input type="button" value="MY PAGE" id = "pageMenu"></a><br>
        <a href="/review/myList"> <input type="button" value="MY REVIEW" id = "pageMenu"></a><br>
        <a href="/mark/list"><input type="button" value="내 즐겨찾기" id = "pageMenu"></a><br>
        <input type="button" value="내 찜목록" id = "pageMenu"><br>
        <a href="/reserv/listUser"><input type="button" value="예약 내역" id = "pageMenu"></a><br>
        <a href="/treat/listUser"><input type="button" value="진료 내역" id = "pageMenu"></a><br>
        <a href="/siljong/list"><input type="button" value="내가 쓴 실종 신고 글" id = "pageMenu"></a><br>
        <input type="button" value="자랑" id = "pageMenu"><br>
        <input type="button" value="커넥팅" id = "pageMenu"><br>
        <a href="/boonyang/myList"> <input type="button" value="내가 쓴 분양 글" id = "pageMenu"></a><br>
            <!-- Add more menu items as needed -->
        </div>
        <div class="content">
                <br><br><br><br><br>
        
     <h1>MYPAGE</h1>
     <p>${mvo.id} 님 안녕하세요.</p>
<div class="info-block">

<div class = "info-item"> 
	<span id="name-span" ><label class="col-sm-1" >이름</label> ${mvo.name}</span>
		 <div class="form-group row" style="display:none;" >
		    <label class="col-sm-1" >이름</label>
		    <div class="col-sm-2">
    			<input type="text" class="form-control" id="name-input" value="${mvo.name}">
    	 	</div>
    	 </div>
</div><!-- info block  -->

<div class = "info-item"> 
	<span id="phone-span" ><label class="col-sm-1" >휴대전화</label> ${mvo.phone}</span>
		 <div class="form-group row" style="display:none;" >
		    <label class="col-sm-1" >휴대전화</label>
		    <div class="col-sm-2">
    			<input type="text" class="form-control" id="phone-input" value="${mvo.phone}">
    	 	</div>
    	 </div>
</div><!-- info block  -->

<div class = "info-item"> 
	<span id="email-span" ><label class="col-sm-1" >이메일</label> ${mvo.email}</span>
    <div style="display:none;" class="form-group row">
        <label class="col-sm-1" >이메일</label>
        <div class="col-sm-2">
            <input type="text" class="form-control" id="email1-input" value="${fn:split(mvo.email, '@')[0]}">
        </div>
        @
        <div class="col-sm-2">
            <input type="text" class="form-control" id ="email2-input"value="${fn:split(mvo.email, '@')[1]}">
        </div>
        <div class = "col-sm-1">
            <select id = "email3-input" class="form-control">
            <option value="self">직접 입력</option>
            <option value="gmail.com">gmail.com</option>
            <option value="naver.com">naver.com</option>
       </select>
         </div> 
    </div> 
</div>
<hr/> <!-- 선 하나 그어짐 -->
<div class = "info-item"> 
	<span id="addr-span" ><label class="col-sm-1" >주소</label> ${mvo.addr1}</span>
		 <div class="form-group row" style="display:none;" >
		    <label class="col-sm-1" >주소</label>
		    <div class="col-sm-2">
    			<input type="text" class="form-control" id="addr-input" value="${mvo.addr1}">
    	 	</div>
    	 </div>
</div><!-- info block  -->
	 
<div class = "info-item">
				<span id='birth-span'><label class="col-sm-1" >생년월일</label><fmt:formatDate value="${mvo.birth}" pattern="yyyy-MM-dd" /></span> 
		 <div class="form-group row" style="display:none;" >
		    <label class="col-sm-1" >생년월일</label>
		    		    <div class="col-sm-2">
<input type='date' class="form-control" id='birth-input' min='1900-01-01' max='2030-12-31' style='display:none;' value="<fmt:formatDate value='${mvo.birth}' pattern='yyyy-MM-dd'/>"/>
						</div>
		</div>
 </div>
 </div>
 
 <div style='float:left;' id = "delete">
<input type="button" id="deleteAccountButton" value="회원탈퇴" style="border: none; background: none; color: black; font-size: small;">
</div>
<div style='float:right;' id = "btn">

   <!-- 취소 버튼 -->
   <input type ="button" value = "취소" class = "edit-button cancel-button" id = "cancelBtn" style ="display:none;">
   <!-- 저장 버튼 -->
   <input type ="button"value = "저장" class = "edit-button save-button" id= "confirmBtn"
      style ="display:none;">
      <input type="button" value="비밀번호 재설정" id="resetPasswordBtn" style="display:none;"class = "edit-button" >
      
   <!-- 수정 버튼 -->
   <input type= "button"value= '수정' class= 'edit-button' id='modifyBtn'>
</div>
       
    
<!-- 모달 시작 -->
<div id="passwordModal" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
   
            <div class="modal-content">
    <div class="modal-header">
        <h4 class="modal-title">비밀번호 재설정</h4>
        <!-- 'x' button with data-dismiss attribute -->
        <button type="button" class="close" data-dismiss="modal">&times;</button>
    </div>
            <div class="modal-body">
            
             <!-- Smaller font size for error message -->
             <div id='passwordChangeMessage' style='color:red; font-size: 12px;'></div>
            
            
                <label for="currentPassword">현재 비밀번호:</label>
                <input type="password" id="currentPassword"><br/>
                <label for="newPassword">새 비밀번호:</label>
                <input type="password" id ="newPassword"><br/>
            </div>
            <!-- Cancel button with data-dismiss attribute in modal-footer div -->
            <div class='modal-footer'>
             	<button id='submitNewPassword' type='button'>확인</button> 
            	<button type='button' data-dismiss='modal' id = 'modalcloseBtn'>취소</button> 
           </div> 
        </div>

    </div>
</div>

<!-- 모달 끝 -->



    </div>
    </div>    

   
 <%@ include file="../includes/footer.jsp"%>
 <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script> 
<script>
$(document).ready(function(){
	$("#modifyBtn").click(function(){
		   $(".info-item span").hide(); // 기존 정보 숨기기
		   $(".info-item input").show(); // 입력 필드 보이기
		   $(".info-item div").show(); // 추가: div도 보이게 하기
		   $(this).hide();
        $("#confirmBtn").show();
        $("#cancelBtn").show();
    $("#resetPasswordBtn").show();
});
	
	$("#cancelBtn").click(function(){
	    $(".info-item span").show(); // 기존 정보 보이기
	    $(".info-item input").hide(); // 입력 필드 숨기기
	    $(".info-item div").hide(); // 추가: div도 숨기게 하기
	    $("#modifyBtn").show();
	    $("#confirmBtn").hide();
	    $("#cancelBtn").hide();
		$("#resetPasswordBtn").hide();
	});
	
    $('#email3-input').change(function() {
        var selected = $(this).val();
        if (selected === 'self') {
            $('#email2-input').val('');
            $('#email2-input').prop('readonly', false);
        } else {
            $('#email2-input').val(selected);
            $('#email2-input').prop('readonly', true);
        }
    });
	
    
    // 회원 탈퇴 링크 클릭 이벤트
    $("#deleteAccountButton").click(function() {
    	var id="${mvo.id}";

        var confirmDelete = confirm("정말 탈퇴하시겠습니까?");
        if (confirmDelete) {
            var csrfHeaderName = "${_csrf.headerName}";
            var csrfTokenValue = "${_csrf.token}";

            $.ajax({
                type: 'POST',
                url: '/member/delete',
                data: JSON.stringify({
                	   "id": id
                	}),
                contentType: "application/json; charset=utf-8",
                beforeSend: function(xhr) {
                    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                },
                success:function(result){
                    alert("탈퇴가 완료되었습니다.");
                    location.href = "/";  // redirect to home page
                },
                error:function(xhr, status, error){
                    alert("탈퇴 실패");
                }
            });
        }
    });
    
    
    $("#confirmBtn").click(function(){
        var csrfHeaderName = "${_csrf.headerName}";
        var csrfTokenValue = "${_csrf.token}";
        
        // 초기값 저장
        var originalBirth = $("#birth-input").val();
        var originalName = $("#name-input").val();
        var originalPhone = $("#phone-input").val();
        var originalEmail1 = $("#email1-input").val();
        var originalEmail2 = ($("#email3-input option:selected" ).text()=="직접 입력")?$("#email2-input" ).val():$("#email3-input option:selected" ).text();
        var originalAddr1= $("#addr-input" ).val();
        var originalEmailDomain = ($("#email3-input option:selected" ).text()=="직접 입력")?$("#email2-input" ).val():$("#email3-input option:selected" ).text();

     // 입력 필드에 값이 없다면 원래 값을 사용
        var birth = $("#birth-input").val() ? $("#birth-input").val() : originalBirth;
  

        var name = $("#name-input").val() ? $("#name-input").val() : originalName;
        if (!name) {
            alert("이름은 필수 입력 항목입니다.");
            return false;
        }

        var phone = $("#phone-input").val() ? $("#phone-input").val() : originalPhone;
        if (!phone) {
            alert("전화번호는 필수 입력 항목입니다.");
            return false;
        }

     // 이메일 주소 확인 - 두 부분으로 나뉘어 있으므로 두 부분 모두 확인
        var emailPart1 = $("#email1-input").val() ? $("#email1-input").val() : originalEmail1;
        if (!emailPart1) {
            alert("이메일 주소는 필수 입력 항목입니다.");
            return false;
        }

        var emailPart2= ($("#email3-select option:selected" ).text()=="직접 입력")?($("#email2-input" ).val()?$("#email2-input" ).val():originalEmailDomain):$("#email3-select option:selected" ).text();
        if (!originalEmailDomain && !$("#email2-input").val()) {
            alert("이메일 도메인은 필수 선택 항목입니다.");
            return false;
        }

        var email=emailPart1+"@"+originalEmailDomain; // 원래 값으로 설정

        // 주소 확인
        var addr1= $("#addr_input" ).val()?$("#addr_input" ).val():originalAddr1 ;
        if (!addr1) {
          alert("주소는 필수 입력 항목입니다.");
          return false; 
        }

    	// ID는 변경되지 않으므로 그대로 사용
    	var id="${mvo.id}";

    	$.ajax({
    	    type: 'post',
    	    url: '/member/update',
    	    data: JSON.stringify({
    	        'id': id,
    	        'name': name,
    	        'phone': phone,
    	        'email': email,
    	        'addr1' : addr1,
    	        'birth' : birth 
    	     }),
    	     beforeSend: function(xhr) {
    	         xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
    	     },
    	     contentType: "application/json; charset=utf-8",
    	      success:function(result){
    	              alert("회원정보가 수정되었습니다.");
    	              location.reload();
    	      },
    	      error:function(xhr, status, error){
    	          alert("수정 실패");
    	      }
    	  });
    });
});

$(document).ready(function() {

    // '비밀번호 재설정'버튼 클릭 시 패스워드 변경 모달 표시
    $("#resetPasswordBtn").click(function() {
        $('#passwordModal').modal('show');
    });
    
    $("#modalcloseBtn").click(function(){
        $('#passwordModal').modal('hide');

    })

    // 패스워드 변경 요청 처리
    $("#submitNewPassword").click(function() {
        var csrfHeaderName = "${_csrf.headerName}";
        var csrfTokenValue = "${_csrf.token}";
        var currentPassword = $("#currentPassword").val();
        var newPassword = $("#newPassword").val();

     // Password validation: 5-20 characters, at least one letter, one number and one special character
        var passwordRegEx = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{5,20}$/;

        if (!newPassword.match(passwordRegEx)) {
            $('#passwordChangeMessage').text("비밀번호는 5~20자의 영문 대/소문자, 숫자, 특수문자 각각 최소 1개 이상 포함해야 합니다.");
            return;
       }

        $.ajax({
            type: "POST",
            url: "/member/updatePassword",
            dataType : 'text',
            data: JSON.stringify({
                "currentPassword": currentPassword,
                "newPassword": newPassword
            }),
            beforeSend: function(xhr) {
                xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
            },
            contentType: "application/json; charset=utf-8",

            success: function(result) {
                alert("패스워드가 성공적으로 변경되었습니다.");
                $('#passwordModal').modal('hide');
                
            },
            error: function(xhr, status, error) {
                if (xhr.responseText === 'unmatch') {
                    $('#passwordChangeMessage').text('현재 패스워드가 올바르지 않습니다.');
                } else { 
                    $('#passwordChangeMessage').text(xhr.responseText);
                }
            }
        });
     });

});
	

	</script>
</body>
</html>
