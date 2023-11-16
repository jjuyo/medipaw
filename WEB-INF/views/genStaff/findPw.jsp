<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<style>
input{
margin: 10px;
}
</style>
   <br><br><br><br><br><br><br>
 <div class="section-title">
          <h2>병원관계자 비밀번호 찾기</h2>
        </div>
<div style="display: flex; flex-direction: column; align-items: center; justify-content: center; ">
    
    <form role="form" action="/genStaff/findPw" method="post">
        <div class="form-group">
            <div style="display: flex; align-items: center;">
                <label for="sname" style="width: 70px; margin-right: 10px;">대표자명</label>
                <input class="form-control" id="sname" placeholder="대표자명" name="sname" type="text" style="width: 150px;" autofocus required>
             </div>
        </div>
        <div class="form-group">
            <div style="display: flex; align-items: center;">
                <label for="sid" style="width: 70px; margin-right: 10px;">아이디</label>
                <input class="form-control" id="sid" placeholder="아이디" name="sid" type="text" style="width: 150px;" autofocus required>
             </div>
        </div>
        <div class="form-group">
            <div style="display: flex; align-items: center;">
                <label for="sphone" style="width: 70px; margin-right: 10px;">연락처</label>
                <input class="form-control" id="sphone" placeholder="-제외하고 입력" name="sphone" style="width: 150px;" required>
          
            </div>
        </div>   
        <a href="/genStaff/login" class="btn btn-info btn-block">로그인</a>
 <input type="submit" value=">>비밀번호찾기" class="btn btn-success btn-block" onclick="return phoneChk();">
        <input type="hidden" name="${_csrf.parameterName}" value= "${_csrf.token}">
    </form>
</div>
<script>
$(function() {
	var result = '${result}';
	checkResult(result);

	history.replaceState({}, null, null); //history 초기화

	function checkResult(result) {
		//result 값이 있는 경우
		if (result === '' || history.state) {
			return;	
		}

		if (result !== null) { 
			swal(result,{icon:'info'});
		}


	}
});
function phoneChk() {
//전화번호
var koreanPhoneNumberPattern = /^(010|011|016|017|018|019)[0-9]{7,8}$/;

var sphone = document.getElementById("sphone").value;

if (!koreanPhoneNumberPattern.test(sphone)) {
	swal("유효하지 않은 전화번호입니다.",{icon:'info'});
	return false;
}
};
</script>
</body>
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
