<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<style>
  .with-margin {
    margin-top: 100px;
  }
  .center-div {
    margin: 0 auto;
    float: none;
  }
  .appointment-btn {
  border: none; /* 테두리 없애기 */
  margin-top: 10px;
  }
  .back-btn {
  margin-left: 25px;
  background: #CFCFCF;
  color: #fff;
  border: none;
  border-radius: 50px;
  padding: 8px 25px;
  white-space: nowrap;
  transition: 0.3s;
  font-size: 14px;
  display: inline-block;
  margin-top: 10px;
  }

  .back-btn:hover {
  background: #BDBDBD;
  color: #fff;
  }

@media (max-width: 768px) {
  .back-btn {
    margin: 0 15px 0 0;
    padding: 6px 18px;
  }
</style>

<%@ include file="../includes/header.jsp" %>

<!-- ======= Doctors Section ======= -->
    <section id="doctors" class="doctors with-margin">
      <div class="container">

        <div class="section-title">
          <h2>진료 정보 등록</h2>
        </div>
        <div class="row">
		<form action="/treat/register" method="post" role="form" id="regFrm">
          <div class="col-lg-6 center-div">
            <div class="member align-items-start">
              <div class="member-info">
                <h4>${reservView.hosName }</h4>
                <p>${reservView.hosAddress }</p>
                <span>${reservView.hosPhone }</span>
                <p>예약자 이름 : ${reservView.name }</p> 
                <p>반려동물 이름 : ${reservView.petName }</p> 
                <p>
	            진료 일자 : 
	              <input type="text" class="form-control" name="trDate" id="trDate" value="${reservView.rvDate }" readonly>
	            </p>
	            <p>
	            진료 시간 : 
	              <input type="text" class="form-control" name="trTime" id="trTime" value="${reservView.rvTime }" readonly>
	            </p>
	            <p>
	            진료 내용 : 
	              <textarea class="form-control" name="trNote" id="trNote" rows="5"></textarea>
	            </p>
              </div>
            </div>
          </div>
          <input type="hidden" name="rvno" id="rvno" value="${reservView.rvno }">
          <input type="hidden" name="hno" id="hno" value="${reservView.hno }">
          <input type="hidden" name="sid" id="sid" value="<sec:authentication property="principal.svo.sid"/>">	<!-- 시큐리티 -->
          <input type="hidden" name="id" id="id" value="${reservView.id }">
          <div class="text-center">
          <button type="button" class="back-btn" onclick="history.back()">돌아가기</button>
          <button type="submit" class="appointment-btn" onclick="confirmRegister(event)">등록하기</button>
          <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"></div>
          </form>
        </div>

      </div>
    </section><!-- End Doctors Section -->
 
<%@ include file="../includes/footer.jsp" %>
<script>
function confirmRegister(event) {
	
	event.preventDefault(); // 기본 동작 중지
	
	swal({
        title: "진료 정보를 등록하시겠습니까?",
        text: "",
        icon: "warning",
        buttons: ["취소", "확인"],
    }).then((willSubmit) => {
        if (willSubmit) {
        	$('#regFrm').submit();  // 폼 전송
        }
    });
	
// 	if (confirm('등록하시겠습니까?')) {
// 	    $('#regFrm').submit(); // 폼 전송
// 	} else {
// 	    event.preventDefault(); // 사용자가 취소를 눌렀을 때만 기본 동작 중지
// 	}
}
</script>
