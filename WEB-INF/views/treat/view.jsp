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
  .rev-btn {
    background: #1977cc;
  }
  .rev-btn:hover {
    background: #166ab5;
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
          <h2>진료 상세 정보</h2>
        </div>
        <div class="row">
		
          <div class="col-lg-6 center-div">
            <div class="member align-items-start">
              <div class="member-info">
                <h4>${view.hvo.animalhosp_name }</h4>
                <p>${view.hvo.hsop_roadname_address }</p>
                <p>${view.hvo.hsop_phonenum }</p>
                <span><strong>${view.mvo.name } ${view.trDate } ${view.trTime }</strong></span>
              	<p>${view.trNote }</p>
              </div>
            </div>
          </div>
          
        </div>

		<form action="/treat/modify" id="modForm">
			<input type="hidden" name="tno" 	value="${view.tno }" id="tno">	
			<input type="hidden" name="animalhosp_no" 	value="${view.hno }">	<!-- 즐겨찾기 등록하기 위한 번호 -->
			<input type="hidden" name="pageNum" value="${cri.pageNum }">
			<input type="hidden" name="amount" 	value="${cri.amount }">
			<input type="hidden" name="type" 	value="${cri.type }">
			<input type="hidden" name="keyword" value="${cri.keyword }">
			<input type="hidden" name="animalhosp_no" value="${view.hno }">
			
			<div class="text-center">
			<sec:authorize access="isAuthenticated()">
			<sec:authentication property="principal" var="p"/>
				<c:if test="${p.username eq 'admin11' || p.username eq view.hvo.sid}">
					<button data-oper="modify" class="btn upd-btn">정보 수정</button>
					<button data-oper="remove" class="btn rem-btn" onclick="confirmDelete(event)">정보 삭제</button></c:if>
				<c:if test="${p.username eq view.id}">
					<button data-oper="remove" class="btn rem-btn" onclick="confirmHide(event)">정보 삭제</button>
				</c:if>
			<!-- 권한에 따라 목록 버튼 보이게 하고 formaction 다르게 지정하기 -->
			<c:if test="${p.username eq 'admin11'}">
			<button data-oper="list" class="btn back-btn" formaction="/treat/listAdm">진료 내역</button></c:if>
			<c:if test="${p.username eq view.id}">
			<button data-oper="list" class="btn back-btn" formaction="/treat/listUser">진료 내역</button>
			<button data-oper="list" class="btn upd-btn" formaction="/review/write" id="reviewButton">리뷰 작성</button></c:if>
			<c:if test="${p.username eq view.hvo.sid}">
			<button data-oper="list" class="btn back-btn" formaction="/treat/listStaff">진료 내역</button></c:if>
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
$(document).ajaxSend(function(e, xhr, options) {
	xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
	});

    $.ajax({
        type: 'post',
        url: '/review/tnoCheck',
        dataType: "json",
        data: { "tno": $("#tno").val() },
        async: false,
        success: function(result) {
            if (result) {
                console.log(result);
                $("#reviewButton").hide();
            }
        }
    });

var result = "${result}";
if (result === 'successM') {
    $(document).ready(function() {
    	swal("진료 정보가 수정되었습니다.", {
            icon: "success",
        });
    });
    result = "";	// result 다시 뜨지 않게 초기화
}
    
    function confirmDelete(event) {
        event.preventDefault(); // 기본 동작 중지

    	swal({
            title: "진료 정보를 삭제하시겠습니까?",
            text: "",
            icon: "warning",
            buttons: ["취소", "확인"],
        }).then((willSubmit) => {
            if (willSubmit) {
            	$('#modForm').attr('action', '/treat/remove'); 	// form의 action 변경
            	$('#modForm').attr('method', 'post'); 			// form의 method 변경
            	$('#modForm').submit(); 						// 폼 전송
            }
        });
        
        // 확인 창 표시
//         if (confirm('진료 정보를 삭제하시겠습니까?')) {
//         	$('#modForm').attr('action', '/treat/remove'); 	// form의 action 변경
//         	$('#modForm').attr('method', 'post'); 			// form의 method 변경
//         	$('#modForm').submit(); 						// 폼 전송
//       	}
    }
    
    function confirmHide(event) {
        event.preventDefault(); // 기본 동작 중지

        swal({
            title: "진료 정보를 삭제하시겠습니까?",
            text: "",
            icon: "warning",
            buttons: ["취소", "확인"],
        }).then((willSubmit) => {
            if (willSubmit) {
            	$('#modForm').attr('action', '/treat/delCheck'); // form의 action 변경
            	$('#modForm').attr('method', 'post'); 			 // form의 method 변경
            	$('#modForm').submit(); 						 // 폼 전송
            }
        });
        
        // 확인 창 표시
//         if (confirm('진료 정보를 삭제하시겠습니까?')) {
//         	$('#modForm').attr('action', '/treat/delCheck'); // form의 action 변경
//         	$('#modForm').attr('method', 'post'); 			 // form의 method 변경
//         	$('#modForm').submit(); 						 // 폼 전송
//       	}
    }
</script>
