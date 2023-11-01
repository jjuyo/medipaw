<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<style>
  .button-container {
    display: flex;
    justify-content: center;
  }
input[readonly] {
    background-color: lightGrey; /* 배경색을 흰색으로 변경 */
}
.form-control {
            width: 60%; /* Set the width to 50% of the container */
            padding: 10px;
            margin: 5px 0;
            border-radius: 4px;
             justify-content: center;
             display: flex;
        }
        	img {
		width: 175px; /* 가로 크기 조절 */
		height: 200px; /* 세로 크기 조절 */
	}
</style>
</head>

<body>
<div class="container">
   <br><br><br><br><br><br><br>
 <div class="section-title">
          <h2>계정 정보 수정</h2>
        </div>

 <div class="row">
        <div class="col-md-10"> <!-- 왼쪽 컨텐츠 영역 -->
            <!-- 내용 입력 -->
        </div>
        <div class="col-md-2"> <!-- 오른쪽 버튼 영역 -->
        
            <button id="pwCheck" type="button" class="btn btn-xs pull-right btn-info">>> 비밀번호 변경</button>
        </div>
    </div>

     <div class="img">
            <label for="img">사업자등록증 사본</label>
            <input type="file" name="img" class="form-control" required>
           <img src="../resources/img/medipaw/${svo.img }" id="cNumImg">
           <button type="button" class="btn btn-danger btn-circle" data-file="${svo.img }" 
	      		 data-type="image">  <i class="fa fa-times"></i>　삭제</button>
        </div>
   <form method="post"  action="/staff/modify">
      <div>
            <label for="sname">대표자명</label>
            <input type="text" id="sname" name="sname" value="${svo.sname }"class="form-control" readonly>
        </div>
        <div>
            <label for="sid">ID</label>
            <input type="text" id="sid" name="sid"  value="${svo.sid }" class="form-control" readonly>
        </div>
        
       		<div >
       		<br>
					<label for="semail">이메일</label><br> 
					<input type="hidden" name="semail" id="semail">
					<div class="col-sm-3">
						<input type="text" name="email1" id="email1"  value="${emailArray[0]}"
							class="form-control">
					</div>
					@
					<div class="col-sm-3">
						<input type="text" name="email2" id="email2" value="${emailArray[1]}"
							class="form-control">
					</div>

					<div class="col-sm-3">
						<select class="form-control" name="email3" id="email3">
							<option>직접입력</option>
									<option ${emailArray[2].equals("gmail.com") ? "selected" : "" }>gmail.com</option>
									<option ${emailArray[2].equals("naver.com") ? "selected" : "" }>naver.com</option>
									<option ${emailArray[2].equals("daum.com") ? "selected" : "" }>daum.com</option>
						</select>
					</div>
				</div>
				
        <div>
            <label for="sphone">연락처</label>
            <input type="text" id="sphone" name="sphone"  value="${svo.sphone }" class="form-control" required>
        </div>
       <div>
            <label for="companyNum">사업자등록번호</label>
            <input type="text" id="companyNum"  value="${svo.companyNum }" name="companyNum" class="form-control" readonly>
        </div>
     
        <hr class="my-4">
        <div class="button-container">
    <div class="form-group row mt-4">
        <div class="col text-center">
            <input type="submit" value="수정" class="btn btn-info regBtn" onclick="return sjoinChk()">
        </div>
        <div class="col text-center">
            <button class="btn btn-secondary cancelBtn" onclick="goBack()" type="button" style="width:70px;">이전</button>
        </div>
    </div>
</div>
	<input type="hidden" name="pageNum" value="${cri.pageNum }">
					<input type="hidden" name="amount"  value="${cri.amount}">
					<input type="hidden" name="type" value="${cri.type }">
					<input type="hidden" name="keyword"  value="${cri.keyword}">
   <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
   <input type="hidden"  id="img"  name="img" value="${svo.img }"/>
   <input type="hidden"  id="spw"  name="spw" value="${svo.spw }"/>
    </form>
    </div>
  </body>    


<script>
function goBack() {
    history.back();
}
//X 표시 클릭 이벤트 처리 -----------------------------------------
$('.img').on('click', 'button', function() {
	if(confirm('첨부 파일을 삭제하시겠습니까?')){
		$('#cNumImg').attr('src', '');
		 $('.btn-circle').hide();
			$.ajax({
				type : 'post',				 
				url : '/deleteFile2', 		 
				data : { fileName : "${svo.img}"},			 
				dataType : 'text', 
				beforeSend: function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success : function(result, status, xhr) {
							alert(result);
							console.log("${svo.img}");
							
							
				}, //성공시
				error : function(xhr, status, er) {
					console.log("delete error");
				} //에러시
			}); //END ajax;
	}
});



//첨부파일 선택 이벤트 처리 -----------------
var csrfHeaderName = '${_csrf.headerName}';
var csrfTokenValue = '${_csrf.token}';
$('input[type="file"]').on('change', function() {
    var formData = new FormData();
    var file = $('input[type="file"]')[0].files[0]; // 파일을 선택

    formData.append('img', file); // 파일을 FormData에 추가

    $.ajax({
        type: 'post',
        url: '/upload/ajaxAction2',
        data: formData, // FormData를 데이터로 사용
        dataType: 'json',
        processData: false, // false로 설정하여 FormData를 변환하지 않도록 함
        contentType: false, // false로 설정하여 컨텐트 타입을 설정하지 않도록 함
        beforeSend: function(xhr){
            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
        },
        success: function(result, status, xhr) {
            console.log(result.uuid+"_"+result.fileName);
            $("#img").val(result.uuid+"_"+result.fileName);
            $('#cNumImg').attr('src', '../resources/img/medipaw/'+result.uuid+"_"+result.fileName);
        },
        error: function(xhr, status, er) {
            console.log("upload error");
        }
    });
});


$(document).ajaxSend(function(e, xhr, options) {
	xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
	});

function sjoinChk() {
	
	//전화번호
	var koreanPhoneNumberPattern = /^(010|011|016|017|018|019)[0-9]{7,8}$/;
	
	var sphone = document.getElementById("sphone").value;
	
	if (!koreanPhoneNumberPattern.test(sphone)) {
		alert("유효하지 않은 전화번호입니다.");
		return false;
	}
}	
//이메일
var email1 = document.getElementById('email1');
var email2 = document.getElementById('email2');
var email3 = document.getElementById('email3');

email3.onchange = function() {
    if (email3.value === '직접입력') {
        email2.value = '';
        email2.readOnly = false;
    } else {
        email2.value = email3.value;
        email2.readOnly = true;
    }
    setEmailValue(); // 이메일 값 설정 함수 호출 추가
}

function setEmailValue() {

document.getElementById('semail').value = email1.value + '@' + email2.value;
}

// 페이지 로드 시 이메일 값 설정 함수 호출
setEmailValue();
var semail = "${svo.semail}";
function splitEmail(semail) {
	var splitEmail = semail.split("@");
	email1.value = splitEmail[0];
	email2.value = splitEmail[1];
	email3.value = "직접입력"; // or set the appropriate option value
	setEmailValue();
}

// 페이지 로드 시 이메일 값 설정 함수 호출
splitEmail(semail);

//비밀번호 변경 버튼 클릭 이벤트 처리 -------------------
$('#pwCheck').on('click', function() {
	self.location = "/staff/pwCheck?sid=${param.sid}";
});
//END 게시물 등록 버튼 클릭 이벤트 처리
</script>


<%@ include file="/WEB-INF/views/includes/footer.jsp" %>