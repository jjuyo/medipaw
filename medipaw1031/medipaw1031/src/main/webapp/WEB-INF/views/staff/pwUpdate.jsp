<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>


                <div style="display: flex; flex-direction: column; align-items: center; justify-content: center; height: 70vh;">
                         <br><br><br><br><br><br><br>
 				<div class="section-title">
          		<h2>비밀번호 변경</h2>
        		</div>
                    <form role="form" action="/staff/pwUpdate" method="post">
                           <input type="hidden" id="sid" name="sid" value="${param.sid }"/>
                            <div class="form-group">
                              새 비밀번호
                              <input class="form-control" id="spw"  name="spw" type="password" style="width: 200px;"  autofocus required>
                            </div>  
                            <div class="form-group">
                              새 비밀번호 확인
                              <input class="form-control" id="spw2"  name="spw2" type="password" style="width: 200px;"  autofocus required>
                            <span id="passwordMatchResult" style="color: red;"></span>
                            </div>    
                            <br>       
                             <div class="row"> 
                            <div class="col-md-10"> <!-- 왼쪽 컨텐츠 영역 -->
            				 <button type="button"  class="btn btn-xs pull-right btn-secondary" onclick="goBack()" >이전 </button>
       							 </div>
                              <div class="col-md-2">             
                            <input type="submit" value="변경" class="btn btn-xs pull-right btn-info" onclick="return pwChk();">
                      </div>
                      </div>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                    </form>
                </div>
<script>
function goBack() {
    history.back();
}

// 비밀번호 확인 함수
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
};

document.getElementById("spw2").addEventListener("input", checkPasswordMatch);

function pwChk() {
    // 비밀번호 일치 여부를 확인
    if (!checkPasswordMatch()) {
        alert("비밀번호가 일치하지 않습니다!");
        return false; // 폼 제출을 중단
    }

    var passwordPattern = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\/\-=])[A-Za-z\d!@#$%^&*()_+{}\[\]:;<>,.?~\\/\-=']{8,}$/;
    var spw = document.getElementById("spw").value;
    if (!passwordPattern.test(spw)) {
        alert("비밀번호는 알파벳, 숫자, 특수문자를 포함 8글자 이상이어야 합니다.");
        return false;
    }

    return true; // 비밀번호 일치 및 형식 검사를 모두 통과하면 폼 제출을 허용
};
</script>

</body>
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
