<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
 <%@ include file="/WEB-INF/views/includes/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src= "https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=324cb7fd34303372c49d32287955fde6&libraries=services"></script>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script src="/resources/js/animalAddr.js"></script>	
  <title>동물병원 등록 폼</title>
  <style>
    /* CSS 스타일을 적용할 부분입니다 */
    body {
        padding-top: 80px; 
    }
	#days {
	    display: flex;
	    justify-content: space-between;
	}	
	.day {
	    padding: 10px;
	    border: 1px solid #555;
	    border-radius: 5px;
	    cursor: pointer;
	}
	.day.selected {
	    background-color: #BDA4D5 !important;
	}
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 20px;
    }
    h1 {
      text-align: center;
    }
    form {
      max-width: 600px;
      margin: 0 auto;
    }
    label {
      display: block;
      margin-bottom: 10px;
      font-weight: bold;
    }
	input,
    textarea,
  	select {
  	  width: 100%;
  	  padding: 8px;
  	  border-radius: 4px;
  	  border: 1px solid #ccc;
  	  box-sizing : border-box ;
  	  resize : vertical ;
  	}
  	select{
  		height :40 px ;
  	}
  	button{
  		background-color:#4CAF50 ;
  		color:white ;
  		padding :12px 20px ;
  		border:none ;
  		border-radius :4 px ;	
      	cursor:pointer ;	
      	float:right ;	
      	font-size :16 px ;	
      	margin-top :-10 px ;
}
.panel-body {
        padding-top: 100px; 
}
</style>
</head>
<body>
	<div class="row">
    	<div class="col-lg-12">
        	<div class="panel panel-default">
    			<div class="panel-heading">AnimalHosp Register Page</div><br>
    			<!-- 여기다가 옆 메뉴 넣을듯 -->
    				<div class="panel-body">
						<form action="/animalhosp/register" method="POST" accept-charset="UTF-8" onsubmit="return mergeTimeFields()">
						    <label for="animalhosp_name">동물병원 이름:</label>
						    <input type="text" id="animalhosp_name" name="animalhosp_name" required><br><br>
						    
						    <label for="sample4_roadAddress">주소 찾기:</label>
						    <input type="text" id="hsop_roadname_address" name="hsop_roadname_address" placeholder="도로명주소" onclick="sample4_execDaumPostcode()" readonly><br><br>
						    <input type="text" id="hsop_postnum" name="hsop_postnum" placeholder="우편번호" onclick="sample4_execDaumPostcode()" readonly><br><br>
						    
						    <label for="animalhosp_open">영업 시작 시간:</label>
						    <input type="time" id="animalhosp_start" name="animalhosp_start" min="00:00" max="24:00" required>
						    
						    <label for="animalhosp_close">영업 종료 시간:</label>
						    <input type="time" id="animalhosp_close" name="animalhosp_close" min="00:00" max="24:00" required>
						    <input type="hidden" id="animalhosp_open" name="animalhosp_open">
						    <div class="form-group">
						        <label for="animalhosp_rest">휴무일:</label>
						        <div id="days">
						            <div class="day">월</div>
						            <div class="day">화</div>
						            <div class="day">수</div>
						            <div class="day">목</div>
						            <div class="day">금</div>
						            <div class="day">토</div>
						            <div class="day">일</div>
						        </div>
						        <input type="hidden" id="selectedDays" name="animalhosp_rest">
						    </div>
						    
						    <label for="h_phone_num">전화번호:</label>
						    <input type="text" id="hsop_phonenum" name="hsop_phonenum" placeholder="010-0000-0000" required><br><br>
						    
<!-- 						    <label for="animalhosp_pic">사진 첨부:</label> -->
<!-- 						    <input type="file" id="animalhosp_pic" name="animalhosp_pic"> -->
						    
						    <button type="submit" class="btn btn-primary">Submit</button>
						    <sec:authorize access="isAuthenticated()">
								<input type="hidden" name="sid" class="form-control" id="sid" value='<sec:authentication property="principal.username"/>'>
							</sec:authorize>
						    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
						    <input type="hidden" id="a_latitude" name="a_latitude" value="default"><!-- 좌표값 구해서 추가 -->
						    <input type="hidden" id="a_hardness" name="a_hardness" value="default">
						</form>
				</div>
			</div>
		</div>
	</div>
	<script>
$(document).ready(function() {
	var sid = '${pageContext.request.userPrincipal.name}';
    $.ajax({
        url: "/animalhosp/myview",
        method: "GET",
        dataType: "json",
        data: { sid: sid },
        success: function(response) {
            var avo = response;
            console.log(avo);

            if (avo !== undefined && avo !== null && avo.sid !== "NULL") {
                alert('병원이 이미 등록되어 있습니다.');
                window.location.href = 'animalhosp.jsp';
            } else {
                console.log('add');
            }
        },
        error: function(xhr, status, error) {
			console.log("add")
        }
    });
});
</script>
</body>
</html>