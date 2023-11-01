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
  .upd-btn {
    background: #FFDD73;
  }
  .upd-btn:hover {
    background: #F2CB61;
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
          <h2>예약 정보 수정</h2>
        </div>
        <div class="row">
		<form action="/reserv/modify" method="post" role="form" id="modForm">
          <div class="col-lg-6 center-div">
            <div class="member align-items-start">
              <div class="member-info">
                <h4>${view.hosName }</h4>
                <p>${view.hosAddress }</p>
                <p>${view.hosPhone }</p>
                <span>${view.name } ${view.rvDate } ${view.rvTime }</span>
              	<p>반려동물 이름 : 
				    <input type="text" name="petName" class="form-control" value="${view.petName }" required
				        oninput="setCustomValidity('')" oninvalid="setCustomValidity('내용을 입력해주세요.')">
				</p>
				<p>반려동물 종 : 
				    <input type="text" name="petSpecies" class="form-control" value="${view.petSpecies }" required
				        oninput="setCustomValidity('')"  oninvalid="setCustomValidity('내용을 입력해주세요.')">
				</p>
              	<p>반려동물 성별 : 
				  <select name="petGender" id="petGender" class="form-select">
	                <option value="수컷" ${view.petGender == '수컷' ? 'selected' : '' }>수컷</option> 
	                <option value="암컷" ${view.petGender == '암컷' ? 'selected' : '' }>암컷</option>
	                <option value="중성화" ${view.petGender == '중성화' ? 'selected' : '' }>중성화</option>
	              </select></p>
              	<p>반려동물 특이사항 : <textarea name="petNote" class="form-control" rows="5">${view.petNote }</textarea></p>
              </div>
            </div>
          </div>
          	<input type="hidden" name="rvno" 	value="${view.rvno }">
          	<input type="hidden" name="pageNum" value="${cri.pageNum }">
			<input type="hidden" name="amount" 	value="${cri.amount }">
			<input type="hidden" name="type" 	value="${cri.type }">
			<input type="hidden" name="keyword" value="${cri.keyword }">
	          <div class="text-center">
				<sec:authorize access="isAuthenticated()">
				<sec:authentication property="principal" var="p"/>
					<c:if test="${p.username eq view.id || p.username eq 'admin11' || p.username eq view.sid}">
						<button data-oper="modify" class="btn upd-btn" type="submit" onclick="confirmUpdate(event)">수정하기</button>
					</c:if>
				</sec:authorize>
				<!-- 권한에 따라 목록 버튼 보이게 하고 formaction 다르게 지정하기 -->
				<button data-oper="view" class="btn back-btn" formaction="/reserv/view" formmethod="get">예약 정보</button>
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
			  </div><!-- End col-lg-6 -->
	          <c:if test="${not empty p.mvo.id}">
		        <input type="hidden" name="id" value="${p.mvo.id}"></c:if>
		      <c:if test="${not empty p.svo.sid}">
		        <input type="hidden" name="sid" value="${p.svo.sid}"></c:if>
          </form>
        </div><!-- End row -->
        
      </div><!-- End container -->
    </section><!-- End Doctors Section -->

<%@ include file="../includes/footer.jsp" %>

<script>
var petNameInput = $('input[name="petName"]');
var petSpeciesInput = $('input[name="petSpecies"]');

function confirmUpdate(event) {
	// 필드 유효성 검사
    if (!petNameInput[0].checkValidity() || !petSpeciesInput[0].checkValidity()) {
        return; // 필드가 유효하지 않으면 함수 종료
    }
	
    // 확인 창 표시
    if (confirm('정보를 수정하시겠습니까?')) {
    	$('#modForm').submit();  // 폼 전송
  	} else {
  		event.preventDefault();  // 사용자가 취소를 눌렀을 때만 기본 동작 중지
  	}
} // confirmUpdate End

</script>
