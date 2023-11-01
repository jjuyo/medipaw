<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<style>
  .with-margin {
    margin-top: 100px;
  }
  .appointment-btn {
  border: none; /* 테두리 없애기 */
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

 <!-- ======= Appointment Section ======= -->
    <section id="appointment" class="appointment section-bg with-margin">
      <div class="container">

        <div class="section-title">
          <h2>예약하기</h2>
        </div>

        <form action="/reserv/register" method="post" role="form" id="regFrm">
          <div class="row">
            <div class="col-md-4 form-group">
            <label>예약 일자 선택</label><br>
              <input type="date" name="rvDate" id="rvDate" min="2023-01-01" max="2024-12-31" autofocus required
				        oninput="setCustomValidity('')" oninvalid="setCustomValidity('예약 일자를 선택해주세요.')">
            </div>
            <div class="col-md-4 form-group">
            <label>예약 시간 선택</label>
			  <select name="rvTime" id="rvTime" class="form-select">
                <option value="">예약 시간 선택</option>
                <option value="09:00">09:00</option>
                <option value="10:00">10:00</option>
                <option value="11:00">11:00</option>
                <option value="12:00">12:00</option>
                <option value="14:00">14:00</option>
                <option value="15:00">15:00</option>
                <option value="16:00">16:00</option>
                <option value="17:00">17:00</option>
              </select>            </div>
            <div class="col-md-4 form-group">
            <label>반려동물 이름</label>
              <input type="text" class="form-control" name="petName" id="petName" required
				     oninput="setCustomValidity('')" oninvalid="setCustomValidity('내용을 입력해주세요.')">
            </div>
          </div>
          <div class="row">
            <div class="col-md-4 form-group mt-3">
            <label>반려동물 종</label>
              <input type="text" class="form-control" name="petSpecies" id="petSpecies" required
				     oninput="setCustomValidity('')" oninvalid="setCustomValidity('내용을 입력해주세요.')">
            </div>
            <div class="col-md-4 form-group mt-3">
            <label>반려동물 성별</label>
              <select name="petGender" id="petGender" class="form-select">
                <option value="수컷">수컷</option>
                <option value="암컷">암컷</option>
                <option value="중성화">중성화</option>
              </select>
            </div>
            <div class="col-md-4 form-group mt-3">
            <label>반려동물 특이사항</label>
              <textarea class="form-control" name="petNote" id="petNote" rows="5"></textarea>
            </div>
            병원 번호 : <input type="text" name="hno" id="hno">
            <input type="hidden" name="id" id="id" value="<sec:authentication property="principal.mvo.id"/>">
          </div>
			
          <div class="text-center">
          <button type="button" class="back-btn" onclick="history.back()">돌아가기</button>
          <button type="submit" class="appointment-btn" onclick="confirmUpdate(event)">예약하기</button></div>
        <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
        </form>

      </div>
    </section><!-- End Appointment Section -->
 
<%@ include file="../includes/footer.jsp" %>
<script>
var rvDateInput = $('input[name="rvDate"]');
var petNameInput = $('input[name="petName"]');
var petSpeciesInput = $('input[name="petSpecies"]');

var csrfHeaderName = "${_csrf.headerName}";			// csrf 토큰 관련 변수
var csrfTokenValue = "${_csrf.token}";
var rvTimeSelect = $('#rvTime');

$(document).ready(function () {
	// 예약 일자 변경 시 예약 가능한 시간 목록 업데이트
  $('#rvDate').on('change', function () {
  var selectedDate = $(this).val();
  var hnoVal = $('#hno').val();
  rvTimeSelect.find('option').show(); 	// 시간 숨기기 전에 모든 option 보이게 하기
  rvTimeSelect.val(""); 				// 일자가 바뀌면 rvTime 값을 ""로 변경
  updateAvailableTimes(selectedDate, hnoVal); // 시간 숨기기 함수 호출
});
	  
	  // hno 값을 가져오기
	  //var hnoVal = $('#hno').val();

	  function updateAvailableTimes(selectedDate, hnoVal) {
	    console.log(hnoVal);
	    // 서버로 예약 가능한 시간 목록 요청
	    $.ajax({
	      type: "POST",
	      url: "/reserv/duplTime",
	      data: { rvDate: selectedDate, hno: hnoVal },
	      dataType: "json", // JSON 데이터를 기대함
	      beforeSend: function(xhr) {
	        // 전송 전 CSRF 헤더 설정
	        xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	      },
	      success: function (response) {
	        console.log(response);
	        response.forEach(function (reservedTime) { // 이미 예약된 시간 숨기기
	          rvTimeSelect.find('option[value="' + reservedTime + '"]').hide();
	        });
	      }
	    });
	  }
	});


function confirmUpdate(event) {
    // 필드 유효성 검사
    if (!rvDateInput[0].checkValidity() || !petNameInput[0].checkValidity() || !petSpeciesInput[0].checkValidity()) {
        return; // 필드가 유효하지 않으면 함수 종료
    }
    if (confirm('예약하시겠습니까?')) {
        $('#regFrm').submit(); // 폼 전송
    } else {
        event.preventDefault(); // 사용자가 취소를 눌렀을 때만 기본 동작 중지
    }
}	// confirmUpdate End




</script>
