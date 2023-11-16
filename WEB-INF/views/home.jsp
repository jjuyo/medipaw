<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>



  <main id="main">

   
   
 
  <!-- ======= Contact Section ======= -->
    <section id="contact" class="contact">
      <div class="container">

        <div class="section-title">
        <br><br><br><br>
          <h2>Medipaw</h2>
          <p>Welcome to Medipaw - Your Pet's Ultimate Hub

At Medipaw, we understand that your beloved pets are not just animals; they are cherished members of your family. That's why we've created a one-stop online platform to cater to all your pet-related needs.</p>
        </div>

        <div class="row">
          <div class="col-lg-6">
            <iframe src="https://www.google.com/maps/embed/v1/search?q=%EB%8F%99%EB%AC%BC%EB%B3%91%EC%9B%90&key=AIzaSyAcs0Uu6UUF7H5FoeQdFrxJBF7kpeKEKQ0" style="border:0; width: 100%; height: 350px;" allowfullscreen></iframe>
          </div>
 <div class="col-lg-6">
  <br><br><br><br>
  <h4>동물병원을 빠르고 쉽게 찾고 예약해보세요!</h4>
         
          <br><br><br><br>
  
          <div id="services" class="services">
            <div class="row">
                        <div class="row">
            
              <div class="col-lg-4 col-md-6 d-flex align-items-stretch">
                  <div class="icon"><i id="icon" class="fas fa-heartbeat"></i></div>
                  <h4><a href="${pageContext.request.contextPath}/animalhosp/test">동물병원</a></h4>
              </div>
              <div class="col-lg-4 col-md-6 d-flex align-items-stretch ">
                  <div class="icon"><i id="icon" class="fas fa-pills"></i></div>
                  <h4><a href="/petmap">동반지도</a></h4>
              </div>
              </div>
                          <div class="row">
              
              <div class="col-lg-4 col-md-6 d-flex align-items-stretch">
                  <div class="icon"><i id="icon" class="fas fa-hospital-user"></i></div>
                  <h4><a href="/siljong/list">실종신고</a></h4>
              </div>
              <div class="col-lg-4 col-md-6 d-flex align-items-stretch ">
                  <div class="icon"><i id="icon" class="fas fa-notes-medical"></i></div>
                  <h4><a href="/boonyang/list">분양입양</a></h4>
                                </div>
                  
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section><!-- End Contact Section -->
      <!-- Modal  -->
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
			
</main>
<script>
$(function() {
//게시물 처리 결과 알림 모달창 처리 -------------------
var result = '${result}';
checkModal(result);

//모달 창 재출력 방지
history.replaceState({}, null, null); //history 초기화

function checkModal(result) {
	//result 값이 있는 경우에 모달 창 표시
	if (result === '' || history.state) {
		return;
	}

	if (result !== null) { //게시물이 등록된 경우
		$('.modal-body').html(result + '님 가입이 완료되었습니다.');
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
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
