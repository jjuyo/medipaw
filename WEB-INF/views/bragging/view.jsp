<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ include file="../includes/header.jsp" %>
<head>
  <!-- 부트스트랩 CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
  <!-- 부트스트랩 JS와 jQuery, Popper.js -->
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<style>
.originImg img {
    width: 90%;
    height: auto;
}
.col-md-6 {
    display: inline-block;  
}
.btn-toss {
  background-color: #2C4964; /* 토스의 파란색 */
  color: white; /* 글씨 색상 */
  border: none; /* 테두리 없애기 */
  padding: 10px 20px; /* 상하 패딩 10px, 좌우 패딩 20px */
  text-align: center; /* 글씨 가운데 정렬 */
  text-decoration: none; /* 텍스트 밑줄 없애기 */
  display: inline-block; /* 인라인 블록으로 설정 */
  font-size: 16px; /* 글씨 크기 */
  margin: 4px 2px; /* 마진 설정 */
  cursor: pointer; /* 마우스 오버시 손가락 모양으로 변경 */
  border-radius: 4px; /* 둥근 테두리 */
  transition: background-color 0.3s; /* 배경색 변경 애니메이션 */
  width: 200px;
}

.btn-toss:hover {
   color: #2C4964;/* 마우스 오버시 색상 변경 */
}

.btn-toss2 {
  background-color: #2C4964; /* 토스의 파란색 */
  color: white; /* 글씨 색상 */
  border: none; /* 테두리 없애기 */
  padding: 10px 20px; /* 상하 패딩 10px, 좌우 패딩 20px */
  text-align: center; /* 글씨 가운데 정렬 */
  text-decoration: none; /* 텍스트 밑줄 없애기 */
  display: inline-block; /* 인라인 블록으로 설정 */
  font-size: 16px; /* 글씨 크기 */
  margin: 4px 2px; /* 마진 설정 */
  cursor: pointer; /* 마우스 오버시 손가락 모양으로 변경 */
  border-radius: 4px; /* 둥근 테두리 */
  transition: background-color 0.3s; /* 배경색 변경 애니메이션 */
  width: 100px;
}

.btn-toss2:hover {
  color: #2C4964; /* 마우스가 버튼 위에 있을 때의 글씨 색상 */
}

.btn-toss3 {
  background-color: #2C4964; /* 토스의 파란색 */
  color: white; /* 글씨 색상 */
  border: none; /* 테두리 없애기 */
  padding: 10px 20px; /* 상하 패딩 10px, 좌우 패딩 20px */
  text-align: center; /* 글씨 가운데 정렬 */
  text-decoration: none; /* 텍스트 밑줄 없애기 */
  display: inline-block; /* 인라인 블록으로 설정 */
  font-size: 16px; /* 글씨 크기 */
  margin: 4px 2px; /* 마진 설정 */
  cursor: pointer; /* 마우스 오버시 손가락 모양으로 변경 */
  border-radius: 4px; /* 둥근 테두리 */
  transition: background-color 0.3s; /* 배경색 변경 애니메이션 */
  width: 100px;
}

.btn-toss3:hover {
  color: #2C4964; /* 마우스가 버튼 위에 있을 때의 글씨 색상 */
}

.btn-toss4 {
  background-color: #2C4964; /* 토스의 파란색 */
  color: white; /* 글씨 색상 */
  border: none; /* 테두리 없애기 */
  padding: 10px 20px; /* 상하 패딩 5px, 좌우 패딩 5px */
  text-align: center; /* 글씨 가운데 정렬 */
  text-decoration: none; /* 텍스트 밑줄 없애기 */
  display: inline-block; /* 인라인 블록으로 설정 */
  font-size: 16px; /* 글씨 크기 */
  margin: 4px 2px; /* 마진 설정 */
  cursor: pointer; /* 마우스 오버시 손가락 모양으로 변경 */
  border-radius: 4px; /* 둥근 테두리 */
  transition: background-color 0.3s; /* 배경색 변경 애니메이션 */
  width: 100px;
}

.btn-toss4:hover {
  color: #2C4964; /* 마우스가 버튼 위에 있을 때의 글씨 색상 */
}

</style>
<div class="container">
	<div class="row mt-5">
	    <div class="col-lg-12">
	     	<h3 class="page-header" style="margin-top: 100px; color:#2C4964; font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif; font-weight: bold;">자랑게시판 > 상세보기</h3>
	    </div>
	  </div>
    <!-- 게시물 상세보기 카드 -->
	  <div class="row mt-3">
	    <div class="col-lg-12">
	      <div class="card border-0 rounded-0">
               <!-- 게시물 상세 정보 -->
			        <div class="card-header bg-white border-light">
					  <div class="row">
					    <div class="col-sm-12 text-left">
					      <div class="row">
					        <div class="col-md-2">
					          <label for="title" class="font-weight-bold" style="color:#2C4964; font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;">작성일</label>
					          <p class="card-text"><fmt:formatDate value="${bbvo.regDate}" pattern="yyyy.MM.dd HH:mm (E)"/></p>
					        </div>
					        <div class="col-md-2">
					            <label for="title" class="font-weight-bold" style="color:#2C4964; font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;">글쓴이</label>
					          <p class="card-text">${bbvo.id}</p>
					        </div>
					        <div class="col-md-2">
					          <label for="title" class="font-weight-bold" style="color:#2C4964; font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;">조회수</label>
					          <p class="card-text">${bbvo.hit}</p>
					        </div>
					        <div class="col-md-2">
					            <label for="title" class="font-weight-bold" style="color:#2C4964; font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;">추천수</label>
					          <p class="card-text"><span id="recommendCnt">${bbvo.recommendCnt}</span></p>
					        </div>
					      </div>
					    </div>
					  </div>
					</div>
						 <div class="card-body">
						  <div class="form-group">
						   <label for="title" class="font-weight-bold" style="color:#2C4964; font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;">제목</label>
						    <input type="text" id="title" name="title" class="form-control rounded-30" value="${bbvo.title}" readonly style="background-color: white; color: black;">
						  </div>			
						  <div class="form-group">
						    <label for="title" class="font-weight-bold" style="color:#2C4964; font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;">내용</label>
						    <textarea id="content" name="content" class="form-control rounded-30" rows="3" readonly style="background-color: white; color: black;">${bbvo.content}</textarea>
						  </div>
						</div>
		            </div> 
		           </div>
           
							  
				<div class="d-flex justify-content-center" style="height: 15vh; align-items: center;">
				  <button id="recommend-button" type="button" class="btn btn-toss" style="margin-bottom: 50px; font-weight: bold;">추천</button>
				</div>
				
				<div class="d-flex justify-content-end">
				  <form action="/bragging/modify" method="get" style="margin-right: 5px;">
				  	<input type="hidden" name="${_csrf.parameterName }"   value="${_csrf.token }">
				    <input type="hidden" name="bno" value="${bbvo.bno }">
				     <!-- 로그인한 사용자가 작성한 글 - 수정버튼표시 -->
					<sec:authorize access="isAuthenticated()">
						<sec:authentication property="principal" var="p"/>
							<c:if test="${p.username == bbvo.id }">
				    			<button data-oper="modify" class="btn btn-toss2" style=" font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif; font-weight: bold;">수정</button> 
				    		</c:if>
				    	</sec:authorize>
				  </form>
				  <form action="/bragging/remove" method="post" style="margin-right: 5px;">
				 	 <input type="hidden" name="${_csrf.parameterName }"   value="${_csrf.token }">
				    <input type="hidden" name="bno" value="${bbvo.bno }">
				    <input type="hidden" name="id" value="${bbvo.id}">
				   <!-- 로그인한 사용자가 작성한 글 - 삭제 버튼 표시 -->
				    <!-- 로그인한 사용자가 작성한 글 - 삭제 버튼 표시 -->
    <sec:authorize access="isAuthenticated()">
        <sec:authentication property="principal.username" var="username"/>
        <c:set var="isCurrentUserPostOwner" value="${username eq bbvo.id}" scope="request"/>
        
        <c:if test="${isCurrentUserPostOwner}">
            <button data-oper="remove" class="btn btn-toss3"
                    style="font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif; font-weight:bold;">
                삭제
            </button>
        </c:if>
    </sec:authorize>
				  </form>
					<button data-oper="list" class="btn btn-toss4" onclick="goToListPage()" style=" font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif; font-weight: bold;">목록</button>
				</div>
					
					<!-- 페이지 번호와 페이지에 표시할 게시물의 수, 검색 타입, 키워드 -->
                	<input type="hidden" name="type" 	value="${bcri.type}">
                	<input type="hidden" name="keyword" value="${bcri.keyword}">	
					<input type="hidden" name="pageNum" value="${bcri.pageNum}">
                	<input type="hidden" name="amount"  value="${bcri.amount}">
                	<input type="hidden" name="bno" value="${bbvo.bno }">
                	
			
			<!-- </form> -->
            
            </div>	<!-- END 게시물 등록 폼 -->
        </div>  	<!-- /.panel -->
  

<!-- 첨부 파일 ------------------------------->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                Attach File 
            </div>	<!-- /.panel-heading -->
            <div class="panel-body" style="display: flex;">
				<!-- 업로드 결과 출력 -->
				<div class="uploadResult" style="width: 50%;">
					<ul> </ul>
				</div>
				<!-- END 업로드 결과 출력 -->
				
				<!-- 썸네일 원본 이미지 표시 -->
				<div class="originImgDiv" style="width: 50%; display: none;">
					<div class="originImg"></div>
				</div>
				<!-- END 썸네일 원본 이미지 표시 -->
            </div> <!-- /.panel-body -->
        </div>   <!-- /.panel -->
       </div>
    </div>       <!-- container -->	
<!-- END 첨부 파일 --------------------------->
 
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
var bnoVal = '${bbvo.bno}';
var csrfHeaderName = '${_csrf.headerName}';	//CSRF 토큰 관련 변수
var csrfTokenValue = '${_csrf.token}';		//
$(document).ajaxSend(function(e, xhr, options){
	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
});


$('#recommend-button').on('click', function() {
    var bno = '${bbvo.bno}';
    var id = '<sec:authentication property="principal.username"/>';
    var writerId = '${bbvo.id}';  // 게시글 작성자 아이디. 실제 코드에 맞게 수정해주세요.

    if (id === writerId) {
        alert('자신이 작성한 게시물은 추천할 수 없습니다.');
        return;
    }

    console.log("bno: " + bno);
    console.log("id: " + id);

    $.ajax({
        url: '/bragging/recommend',
        type: 'post',
        contentType: 'application/json;charset=UTF-8',
        data: JSON.stringify({
            bno: bno,
            id: id
        }),
        beforeSend : function(xhr){	//xhr ; XML Http Request
			//전송 전 CSRF 헤더 설정
		//	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		// 시큐리티
		}, 
        success: function(response) {
            // Assuming that 'response' is the updated count of recommendations.
            $("#recommendCnt").text(response);
            alert('추천되었습니다!');
        },
        error: function(request, status, error) {
            alert('게시물 당 1번만 추천 가능합니다');
        }
    });
});


var csrfHeaderName = '${_csrf.headerName}';	//CSRF 토큰 관련 변수
var csrfTokenValue = '${_csrf.token}';		//
$(document).ajaxSend(function(e, xhr, options){
	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
});
//END beforeSend 대신 CSRF 토큰 헤더 추가 -------


//첨부 파일 목록 가져오기 ----------------------------
(function(){ 
	$.getJSON('/bragging/brAttachList', { bno : bnoVal }, function(result){
		console.log(result);
		
		showUploadedFile(result);
	});//END getJSON()	
})();//END 첨부 파일 목록 가져오기 -------------------

//업로드 결과 출력 ----------------------------------------------
var resultUL = $('.uploadResult ul');  
function showUploadedFile(result){  
	$(result).each(function(i, obj){  
		var liTag = '';  // Move this line inside the loop

		//서버로 전송할 정보를 li 태그의 속성으로 저장
		var filePath = encodeURIComponent(
			obj.uploadPath + "/" +
			obj.uuid + "_" +
			obj.fileName);
		
		var thumbImg = encodeURIComponent(
			obj.uploadPath + "/s_" +
			obj.uuid + "_" +
			obj.fileName);

		if(obj.fileType){	
		    // 이미지는 썸네일과 파일명 표시
		    liTag += '<li data-uuid="' + obj.uuid + '" ' + 
		        ' data-uploadph="' + obj.uploadPath + '" ' + 
		        ' data-filenm="' + obj.fileName+ '" ' +
		        ' data-filetp="' + obj.fileType+ '">';

		    liTag += '<img src="/bragging/display?fileName='+ thumbImg +'"><br>' +
		        '<button class="btn btn-primary download-btn" data-filepath="'+filePath+'">Download</button><br>' +
		        obj.fileName+'</li>';		 
	    } else { 		
	        // 일반 파일은 attach.png 이미지와 파일명 표시
	        liTag += '<li><img src="/resources/img/attach.png"><br>'+ 
	            '<button class="btn btn-primary download-btn" data-filepath="'+filePath+'">Download</button><br>'+
	            obj.fileName+'</li>';	
	    }
	    resultUL.append(liTag);
    });
}

function goToListPage() {
    var type = '${bcri.type}';
    var keyword = '${bcri.keyword}';
    var pageNum = ${bcri.pageNum};
    var amount = ${bcri.amount};

    location.href = '/bragging/list?type=' + type + '&keyword=' + keyword + '&pageNum=' + pageNum + '&amount=' + amount;
}


//첨부파일 클릭 이벤트 처리 ----------------------------------------
$('.uploadResult').on('click', 'li img', function(e){
    var li = $(this).parent();
    var filePath = '/bragging/display?fileName='+
        encodeURIComponent(li.data('uploadph')+"/"+li.data('uuid')+"_"+li.data('filenm'));

    if(li.data('filetp')) {
        if (li.hasClass('active')) {
            $('.originImg').animate({width:'0%', height:'0%'}, 1000);
            setTimeout(() => { 
                $('.originImgDiv').hide(); 
                li.removeClass('active');
            }, 1000);
        } else {
            $('.uploadResult li.active').removeClass('active');
            li.addClass('active');

            $('.originImgDiv').css('display', 'flex').show();
            $('.originImg').html('<img src="'+filePath+'">')
                .animate({width:'100%', height:'100%'}, 1000);
        }
    }
});
//END 첨부파일 클릭 이벤트 처리 ----------------------------------------

//Download button event
$(".uploadResult").on('click', '.download-btn', function() {
    var filePath = $(this).data("filepath");
    
    window.location.href = "/bragging/download?fileName=" + filePath;
});

//썸네일 원본 이미지 또는 다른 썸네일 클릭 이벤트 처리 -------------------------------------
$('.originImgDiv, .uploadResult li img').on('click', function(){
	if ($(this).hasClass('.active')) {
		$('.originImg').animate({width:'0%', height:'0%'}, 1000);
		setTimeout(() => { $('.originImgDiv').hide(); }, 1000);
	}
});//END 썸네일 원본 이미지 또는 다른 썸네일 클릭 이벤트 처리 ------------------------------
</script>

<%@ include file="../includes/footer.jsp" %>	

















