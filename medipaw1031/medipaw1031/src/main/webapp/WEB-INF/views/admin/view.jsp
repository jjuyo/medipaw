<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<style>
  .button-container {
    display: flex;
    justify-content: center;
  }
input[readonly] {
    background-color: lightGrey; /* 배경색을 흰색으로 변경 */
}
.form-control {
            width: 60%; /* Set the width to 50% of the container */
            padding: 10px;
            margin: 5px 0;
            border-radius: 4px;
             justify-content: center;
             display: flex;
        }
        	img {
		width: 175px; /* 가로 크기 조절 */
		height: 200px; /* 세로 크기 조절 */
	}
</style>
</head>

<body>
<div class="container">
<br><br><br><br><br><br><br>
 <div class="section-title">
          <h2>계정 정보</h2>
        </div>
     <div class="img">
            <label for="img">사업자등록증 사본</label>
           <img src="../resources/img/medipaw/${svo.img }" id="cNumImg">
        </div>
   <form method="post">
      <div>
            <label for="sname">대표자명</label>
            <input type="text" id="sname" name="sname" value="${svo.sname }"class="form-control" readonly>
        </div>
        <div>
            <label for="sid">ID</label>
            <input type="text" id="sid" name="sid"  value="${svo.sid }" class="form-control" readonly>
        </div>
        
       		<div>
       		<br>
					<label for="semail">이메일</label><br> 
					<input type="text" id="semail" name="semail" value="${svo.semail }" class="form-control" readonly>
				</div>
				
        <div>
            <label for="sphone">연락처</label>
            <input type="text" id="sphone" name="sphone"  value="${svo.sphone }" class="form-control" readonly>
        </div>
       <div>
            <label for="companyNum">사업자등록번호</label>
            <input type="text" id="companyNum"  value="${svo.companyNum }" name="companyNum" class="form-control" readonly>
        </div>
     
        <hr class="my-4">
        <div class="button-container">
    <div class="form-group row mt-4">
        <div class="col text-center">
          <button data-oper="list" class="btn btn-primary"
						formaction="/admin/staffList" formmethod="get" style="width:70px;">목록</button>
        </div>
        <div class="col text-center">
           <a class="btn btn-warning" href="/staff/modify?sid=${param.sid }">수정</a>
            </div>
             <div class="col text-center">
           <button data-oper="remove" class="btn btn-danger" formaction="/admin/removeByAdmin" onclick="return delChk();">삭제</button>
        </div>
    </div>
</div>
	<input type="hidden" name="pageNum" value="${cri.pageNum }">
					<input type="hidden" name="amount"  value="${cri.amount}">
					<input type="hidden" name="type" value="${cri.type }">
					<input type="hidden" name="keyword"  value="${cri.keyword}">
   <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
   <input type="hidden"  id="img"  name="img" value=""/>
    </form>
    </div>
  </body>    

	<script>
	var result = '${result}';
	if (result !== null && result !== '') {
	    alert(result);
	}
	// 변수를 사용하여 이미지 상태를 추적합니다.
	var isExpanded = false;

	$('.img').on('click', function () {
	    if (isExpanded) {
	        // 이미지가 확대된 경우, 원래 크기로 축소
	        $('#cNumImg').animate({ width: '250px', height: '250px' }, 1000);
	        isExpanded = false;
	    } else {
	        // 이미지가 축소된 경우, 확대
	        $('#cNumImg').animate({ width: '70%', height: '70%' }, 1000);
	        isExpanded = true;
	    }
	});
	function delChk(){
		if(confirm('정말 삭제하시겠습니까? ')){
		}
		else {
	        // "취소"를 클릭한 경우, 아무 동작도 수행하지 않고 현재 페이지에 머물기
	        return false;
	    }
	}
		function goBack() {
			history.back();
		}
	</script>
<%@ include file="/WEB-INF/views/includes/footer.jsp"%>