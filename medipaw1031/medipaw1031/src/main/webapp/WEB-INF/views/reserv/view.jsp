<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp" %>
<style>
  .with-margin {
    margin-top: 100px;
  }
  .center-div {
    margin: 0 auto;
    float: none;
  }
  .text-center {
    text-align: center;
  }
  .btn {
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
    margin-left: 25px;
  }
  .btn:hover {
    background: #BDBDBD;
    color: #fff;
  }
  .treat-btn {
    background: #79ABFF;
  }
  .treat-btn:hover {
    background: #6799FF;
  }
  .upd-btn {
    background: #FFDD73;
  }
  .upd-btn:hover {
    background: #F2CB61;
  }
  .rem-btn {
    background: #FF8383;
  }
  .rem-btn:hover {
    background: #FF7171;
  }
  .back-btn {
    background: #CFCFCF;
  }
  .back-btn:hover {
    background: #BDBDBD;
  }
</style>


<!-- ======= Doctors Section ======= -->
    <section id="doctors" class="doctors with-margin">
      <div class="container">

        <div class="section-title">
          <h2>예약 상세 정보</h2>
        </div>
        <div class="row">
		
          <div class="col-lg-6 center-div">
            <div class="member align-items-start">
              <div class="member-info">
                <h4>${view.hosName }</h4>
                <p>${view.hosAddress }</p>
                <p>${view.hosPhone }</p>
                <span><strong>${view.name } ${view.rvDate } ${view.rvTime }</strong></span>
              	<p>${view.petName }</p>
              	<p>${view.petSpecies }</p>
              	<p>${view.petGender }</p>
              	<p>${view.petNote }</p>
              </div>
            </div>
          </div>
          
        </div>

		<form action="/reserv/modify" id="modForm">
			<input type="hidden" name="rvno" 	value="${view.rvno }">	
<%-- 			<input type="hidden" name="id" 		value="<sec:authentication property="principal.mvo.id"/>">	<!-- 시큐리티 --> --%>
<%-- 			<input type="hidden" name="sid" 	value="<sec:authentication property="principal.svo.sid"/>">	<!-- 시큐리티 --> --%>
			<input type="hidden" name="pageNum" value="${cri.pageNum }">
			<input type="hidden" name="amount" 	value="${cri.amount }">
			<input type="hidden" name="type" 	value="${cri.type }">
			<input type="hidden" name="keyword" value="${cri.keyword }">
			
			<div class="text-center">
			<sec:authorize access="isAuthenticated()">
			<sec:authentication property="principal" var="p"/>
				<c:if test="${p.username eq view.sid }">
					<button data-oper="treat" class="btn treat-btn" formaction="/treat/register">진료 완료</button>
				</c:if>
				<c:if test="${p.username eq view.id || p.username eq 'admin11' || p.username eq view.sid}">
					<button data-oper="modify" class="btn upd-btn">정보 수정</button>
					<button data-oper="remove" class="btn rem-btn" onclick="confirmDelete(event)">예약 취소</button>
				</c:if>
			<!-- 권한에 따라 목록 버튼 보이게 하고 formaction 다르게 지정하기 -->
			<c:if test="${p.username eq 'admin11'}">
			<button data-oper="list" class="btn back-btn" formaction="/reserv/listAdm">예약 내역</button></c:if>
			<c:if test="${p.username eq view.id}">
			<button data-oper="list" class="btn back-btn" formaction="/reserv/listUser">예약 내역</button></c:if>
			<c:if test="${p.username eq view.sid}">
			<button data-oper="list" class="btn back-btn" formaction="/reserv/listStaff">예약 내역</button></c:if>
			</sec:authorize>
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
			</div>
			<c:if test="${not empty p.mvo.id}">
		        <input type="hidden" name="id" value="${p.mvo.id}"></c:if>
		    <c:if test="${not empty p.svo.sid}">
		        <input type="hidden" name="sid" value="${p.svo.sid}"></c:if>
		</form>

      </div>
    </section><!-- End Doctors Section -->
 
<%@ include file="../includes/footer.jsp" %>

<script>
var result = "${result}";

if (result === 'successM') {
    $(document).ready(function() {
        alert("수정되었습니다.");
    });
    result = "";	// result 다시 뜨지 않게 초기화
}
    
    $(document).ready(function() {
        var treatCnt = ${treatCnt };
        if (treatCnt >= 1) {
            // treatCnt가 1 이상인 경우 진료 완료, 예약 취소 버튼 숨기기
            $('.treat-btn').hide();
            $('.rem-btn').hide();
        }
    });
    
    function confirmDelete(event) {
        event.preventDefault(); // 기본 동작 중지

        // 확인 창 표시
        if (confirm('예약을 취소하시겠습니까?')) {
        	$('#modForm').attr('action', '/reserv/remove'); // form의 action 변경
        	$('#modForm').attr('method', 'post'); 			// form의 method 변경
        	$('#modForm').submit(); 						// 폼 전송
      	}
    }
</script>
