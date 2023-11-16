<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>


                <div style="display: flex; flex-direction: column; align-items: center; justify-content: center; height: 70vh;">
                 <br><br><br><br><br><br><br>
 			<div class="section-title">
          		<h2>비밀번호 변경</h2>
       		 </div>
                    <form role="form" action="/staff/pwCheck" method="post">
                      <input type="hidden" id="sid" name="sid" value="${param.sid }"/>
                            <div class="form-group">
                              현재 비밀번호를 입력하세요. <br>
                              <input class="form-control" id="spw"  name="spw" type="password" style="width: 200px;"  autofocus required>
                            </div>    
                            <br>       
                             <div class="row"> 
                            <div class="col-md-10"> <!-- 왼쪽 컨텐츠 영역 -->
            				 <button type="button"  class="btn btn-xs pull-right btn-secondary" onclick="goBack()" >이전 </button>
       							 </div>
                              <div class="col-md-2">             
                            <input type="submit" value="다음" class="btn btn-xs pull-right btn-info">
                      </div>
                      </div>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                    </form>
                </div>
<script>
function goBack() {
    history.back();
}
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
</script>
</body>
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
