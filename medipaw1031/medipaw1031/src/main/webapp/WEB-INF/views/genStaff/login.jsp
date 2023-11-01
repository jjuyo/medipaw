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
          <h2>병원관계자 로그인</h2>
        </div>
<div style="display: flex; flex-direction: column; align-items: center; justify-content: center; ">

    <h4 style="color: red">${error}</h4>
    <h4 style="color: red">${logout}</h4>
    
    <form role="form" action="/login" method="post">
        <div class="form-group">
            <div style="display: flex; align-items: center;">
                <label for="username" style="width: 70px; margin-right: 10px;">아이디</label>
                <input class="form-control" id="username" placeholder="ID" name="username" type="text" style="width: 150px;" value="kimnara" autofocus>
                <a href="/genStaff/findId" style="text-decoration: none; margin-left: 10px;">아이디 찾기</a>
            </div>
        </div>
        <div class="form-group">
            <div style="display: flex; align-items: center;">
                <label for="password" style="width: 70px; margin-right: 10px;">비밀번호</label>
                <input class="form-control" id="password" placeholder="Password" name="password" type="password" style="width: 150px;" value="asdf1234$">
                <a href="/genStaff/findPw" style="text-decoration: none; margin-left: 10px;">비밀번호 찾기</a>
            </div>
        </div>
        <div class="checkbox">
            <label>
                <input name="remember-me" type="checkbox">Remember Me
            </label>
        </div>
        <input type="submit" value="Login" class="btn btn-lg btn-success btn-block">
        <a href="/" class="btn btn-lg btn-info btn-block">홈페이지</a>

        <input type="hidden" name="${_csrf.parameterName}" value= "${_csrf.token}">
    </form>
</div>
  <!-- Modal 게시물 등록 완료 시 표시 -->
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
					aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true">&times;</button>
								<h4 class="modal-title" id="myModalLabel">MESSAGE</h4>
							</div>
							<div class="modal-body">처리가 완료되었습니다.</div>
							<div class="modal-footer">
								  <button type="button" class="btn btn-default close" data-dismiss="modal">닫기</button>
					
							</div>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>
				<!-- /.modal -->
<script>
$(function() {
//게시물 처리 결과 알림 모달창 처리 -------------------
var result = '${foundId}';
checkModal(result);

//모달 창 재출력 방지
history.replaceState({}, null, null); //history 초기화

function checkModal(result) {
	//result 값이 있는 경우에 모달 창 표시
	if (result === '' || history.state) {
		return;
	}

	if (result !== null) { //게시물이 등록된 경우
		$('.modal-body').html("아이디는 "+ result + '입니다.');
		console.log(result);
	}

	$('#myModal').modal('show');
}

//END 게시물 처리 결과 알림 모달창 처리
});
$(".close").on("click", function(){
	$('#myModal').modal('hide');
});
</script>
</script>
</body>
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
