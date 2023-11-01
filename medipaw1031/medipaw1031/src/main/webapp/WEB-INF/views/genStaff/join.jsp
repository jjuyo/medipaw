<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<style>
.terms__content{
	border:1px solid;
	solid: grey; /* 테두리 두께와 색상 설정 */
    padding: 10px; /* 내용과 테두리 사이의 간격 설정 */
}
  .button-container {
    display: flex;
    justify-content: center;
  }

.form-control {
            width: 60%; /* Set the width to 50% of the container */
            padding: 10px;
            margin: 5px 0;
            border-radius: 4px;
             justify-content: center;
             display: flex;
        }
</style>
</head>

<body>
<div class="container">
   <br><br><br><br><br><br><br>
 <div class="section-title">
          <h2>병원관계자 가입</h2>
        </div>

     <div>
            <label for="img">사업자등록증 사본</label>
            <input type="file" name="img" class="form-control" required>
           <img src="" id="cNumImg" style="display: none;">

        </div>
   <form method="post"  action="/genStaff/join">
      <div>
            <label for="sname">대표자명</label>
            <input type="text" id="sname" name="sname" class="form-control" required>
        </div>
        <div>
            <label for="sid">ID</label>
            <input type="text" id="sid" name="sid" class="form-control" required>
            <button id="idCheckBtn" type="button" onclick="idCheck();" value="N" style="background-color: #FFFF99">중복확인</button>
        </div>
        
        <div>
            <label for="spw1">비밀번호</label>
            <input type="password" id="spw" name="spw" class="form-control" required>
        </div>
        <div>
            <label for="spw2">비밀번호 확인</label>
            <input type="password" id="spw2" name="spw2"class="form-control" required>
             <span id="passwordMatchResult" style="color: red;"></span>
        </div>
       		<div class="form-group row">
       		<br>
					<label for="semail">이메일</label><br> 
					<input type="hidden" name="semail" id="semail">
					<div class="col-sm-3">
						<input type="text" name="email1" id="email1" 
							class="form-control">
					</div>
					@
					<div class="col-sm-3">
						<input type="text" name="email2" id="email2" 
							class="form-control">
					</div>

					<div class="col-sm-3">
						<select class="form-control" name="email3" id="email3">
							<option selected>직접입력</option>
							<option>gmail.com</option>
							<option>naver.com</option>
							<option>daum.com</option>
						</select>
					</div>
				</div>
				
        <div>
            <label for="sphone">연락처</label>
            <input type="text" placeholder="-제외하고 입력"  id="sphone" name="sphone" class="form-control" required>
        </div>
       <div>
            <label for="companyNum">사업자등록번호</label>
            <input type="text" id="companyNum" name="companyNum" class="form-control" required>
        	 <button id="cNumCheckBtn" type="button" onclick="cNumCheck();" value="N" style="background-color: #FFFF99">상태조회</button>
       		<span id="result" style="color: red;"> </span>
        </div>
     <label for="agree_all">
  <input type="checkbox" name="agree_all" id="agree_all">
  <span>모두 동의합니다</span>
</label><br>
<label for="agree">
  <input type="checkbox" name="agree" value="1" required>
  <span>이용약관 동의<strong>(필수)</strong></span>
</label><br>
<div class="terms__content">
                여러분을 환영합니다. 메디파우 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 메디파우
                서비스의 이용과 관련하여 메디파우 서비스를 제공하는 메디파우 주식회사(이하 ‘메디파우’)와 이를 이용하는 메디파우 서비스
                회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 메디파우 서비스 이용에 도움이 될 수 있는
                유익한 정보를 포함하고 있습니다. 메디파우 서비스를 이용하시거나 메디파우 서비스 회원으로 가입하실 경우 여러분은 본
                약관 및 관련 운영 정책을 확인하거나 동의하게 되므로, 잠시 시간을 내시어 주의 깊게 살펴봐 주시기
                바랍니다.
              </div>

<label for="agree">
  <input type="checkbox" name="agree" value="2" required>
  <span>개인정보 수집, 이용 동의<strong>(필수)</strong></span>
</label><br>
 <div class="terms__content">
                개인정보보호법에 따라 메디파우에 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 및
                이용목적, 개인정보의 보유 및 이용기간, 동의 거부권 및 동의 거부 시 불이익에 관한 사항을 안내 드리오니
                자세히 읽은 후 동의하여 주시기 바랍니다.1. 수집하는 개인정보 이용자는 회원가입을 하지 않아도 정보 검색,
                뉴스 보기 등 대부분의 네이버 서비스를 회원과 동일하게 이용할 수 있습니다. 이용자가 메일, 캘린더, 카페,
                블로그 등과 같이 개인화 혹은 회원제 서비스를 이용하기 위해 회원가입을 할 경우, 네이버는 서비스 이용을
                위해 필요한 최소한의 개인정보를 수집합니다.
              </div>
        <hr class="my-4">
        <div class="button-container">
    <div class="form-group row mt-4">
        <div class="col text-center">
            <input type="submit" value="병원관계자 가입" class="btn btn-info regBtn" onclick="return sjoinChk()">
        </div>
        <div class="col text-center">
            <button class="btn btn-secondary cancelBtn" onclick="goBack()" type="button">취소</button>
        </div>
    </div>
</div>

   <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
   <input type="hidden"  id="img"  name="img" value=""/>
    </form>
    </div>
  </body>    


<script>
//동의 모두선택 / 해제
const agreeChkAll = document.querySelector('input[name=agree_all]');
    agreeChkAll.addEventListener('change', (e) => {
    let agreeChk = document.querySelectorAll('input[name=agree]');
    for(let i = 0; i < agreeChk.length; i++){
      agreeChk[i].checked = e.target.checked;
    }
});
function goBack() {
    history.back();
}
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
            $('#cNumImg').show(); 
        },
        error: function(xhr, status, er) {
            console.log("upload error");
        }
    });
});


$(document).ajaxSend(function(e, xhr, options) {
	xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
	});
function idCheck() {
    $.ajax({
        type: 'post',
        url: '/genStaff/idCheck',
        dataType: "json", 
        data: { "sid": $("#sid").val() },
        success: function(result) {
            if (result == 1) {
                alert("이미 존재하는 아이디입니다.");
            } else if (result == 0) {
                $("#idCheckBtn").attr("value", "Y");
                alert("사용 가능한 아이디입니다.");
            }
        }
    });
}


function cNumCheck() {	
	var b_no = $("#companyNum").val();
    var data = {"b_no":[b_no]};
	$.ajax({
	  url: "http://cors-anywhere.herokuapp.com/https://api.odcloud.kr/api/nts-businessman/v1/status?serviceKey=9Hrx5cHlgrKpVP5JkztDAbhuROUGnpOCuyIucfo1dfbMXW58mSs/OozCIePXKmhn0sZ6AKDB2yM1Tq5zZ2ESew==",
	  type: "post",
	  data: JSON.stringify(data), // json 을 string으로 변환하여 전송
	  dataType: "json",
	  contentType: "application/json",
	  accept: "application/json",
	  success: function(result) {
		  console.log(result);
		  $("#cNumCheckBtn").attr("value", "Y");
	      $('span#result').html(result.data[0].tax_type);

	  },
	  error: function(result) {
	      console.log(result.responseText); //responseText의 에러메세지 확인
	      console.log(data);
	  }
	});
}
//비밀번호 확인 함수
function checkPasswordMatch() {
    var spw = document.getElementById("spw").value;
    var spw2 = document.getElementById("spw2").value;
    var resultSpan = document.getElementById("passwordMatchResult");

    if (spw !== spw2) {
        resultSpan.textContent = "비밀번호가 일치하지 않습니다.";
        resultSpan.style.color = "red";
        return false;
    } else {
        resultSpan.textContent = "비밀번호가 일치합니다.";
        resultSpan.style.color = "green";
        return true;
    }
}
document.getElementById("spw2").addEventListener("input", checkPasswordMatch);

function sjoinChk() {
	// 비밀번호 일치 여부를 확인
    if (!checkPasswordMatch()) {
    	alert("비밀번호가 일치하지 않습니다!")
        return false; // 폼 제출을 중단
    }
	//아이디 중복확인 여부 체크하기
	var idCheckBtn = $("#idCheckBtn");
    
    if (idCheckBtn.val() === "N") {
       alert("아이디 중복확인은 필수입니다!")
        return false;
    }
	//사업자번호 상태조회 여부 체크하기
		var cNumCheckBtn = $("#cNumCheckBtn");
    
    if (cNumCheckBtn.val() === "N") {
       alert("사업자 상태 조회는 필수입니다!")
        return false;
    }
	//아이디
	var sid = document.getElementById("sid").value;
	
	if (sid.length < 5 || sid.length > 10) {
		alert("아이디는 5자에서 10자 사이로 입력하세요.");
		return false;
	}

	var passwordPattern = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\/\-=])[A-Za-z\d!@#$%^&*()_+{}\[\]:;<>,.?~\\/\-=']{8,}$/;
	var spw = document.getElementById("spw").value;
	if (!passwordPattern.test(spw)) {
		alert("비밀번호는 알파벳, 숫자, 특수문자를 포함 8글자 이상이어야 합니다.");
		console.log(spw);
		return false;
	}
	
	
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
</script>


<%@ include file="/WEB-INF/views/includes/footer.jsp" %>