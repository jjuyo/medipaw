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

.circular {
  box-sizing: border-box;
}

.circular .path {
  stroke-dasharray: var(--top-dash);
}

.circular .path.path--circle {
    animation-duration:
      calc(var(--time) * .875),
      calc(var(--time) * .875);
}
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
            background-color:       #B0C4DE      ;
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
                margin:auto; /* Add this line */
            
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
       
        <div class="content" style="width: 80%;">
                <br><br><br><br><br>
        
     <h1>Member management</h1>
     <div id="loadingMessage" style="display: none;">
    <div class="spinner"></div>
    메일을 전송중입니다...
</div>
     <p>${mvo.id}님의 정보입니다.</p>
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
      <input type="button" value="임시비밀번호 발급" id="temppw" style="display:none;"class = "edit-button" >
      
   <!-- 수정 버튼 -->
   <input type= "button"value= '수정' class= 'edit-button' id='modifyBtn'>
    <input type="button" id="toListButton" value="목록으로" class = "edit-button">
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
        $("#temppw").show();  // 임시 비밀번호 발급 버튼 보여주기 추가
});
   // 목록으로 버튼 클릭 이벤트
   $("#toListButton").click(function() {
       location.href = "/member/list";  // 회원 목록 페이지로 이동
   });
   
   $("#cancelBtn").click(function(){
       $(".info-item span").show(); // 기존 정보 보이기
       $(".info-item input").hide(); // 입력 필드 숨기기
       $(".info-item div").hide(); // 추가: div도 숨기게 하기
       $("#modifyBtn").show();
       $("#confirmBtn").hide();
       $("#cancelBtn").hide();
      $("#temppw").hide();
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
                     location.href = "/member/list";  // redirect to home page
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

   $("#temppw").click(function(){
      
      var csrfHeaderName = "${_csrf.headerName}";
      var csrfTokenValue = "${_csrf.token}";
      var id = "${mvo.id}";
        var confirmTempPassword = confirm("임시비밀번호를 발급하시겠습니까?");
        if (confirmTempPassword) {
            $("#loadingMessage").show(); // 이동: 확인창에서 '확인'을 눌렀을 때만 로딩 메시지 보이기
            $.ajax({
                type: 'POST',
                url: '/member/temppw',
                data: JSON.stringify({
                    "id": id
                }),
                beforeSend: function(xhr) {
                   xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
               },
                contentType: "application/json; charset=utf-8",
                  success:function(result){
                 $("#loadingMessage").hide();
                  alert("임시비밀번호가 발급되었으며, 등록된 이메일로 전송되었습니다.");
               },
               error:function(xhr, status, error){
                    $("#loadingMessage").hide();
                  alert("임시비밀번호 발급 실패");
               }
            });
        }
   });

});
   

   </script>
</body>
</html>