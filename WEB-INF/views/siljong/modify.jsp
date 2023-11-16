<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp" %>
<style>
  .btn-circle.btn-sm {
    width: 20px;
    height: 20px;
    padding: 0;
    font-size: 10px;
    background-color: #B2CCFF;
    border-color: #B2CCFF;
  }
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
    margin-bottom: 10px;
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
  .form-group {
      display: flex;
      flex-direction: row;
      align-items: center;
      margin-bottom: 10px;
  }
  .form-group label {
      width: 80px; /* 레이블 너비 조정 (원하는 너비로 변경 가능) */
      text-align: right; /* 레이블 텍스트를 오른쪽 정렬 */
      margin-right: 30px; /* 레이블과 입력 요소 사이 간격 조정 */
  }
  .form-group input,
  .form-group textarea {
      flex: 1; /* 입력 요소가 가능한 최대 너비를 채우도록 설정 */
  }   
</style>

<!-- ======= Doctors Section ======= -->
    <section id="doctors" class="doctors with-margin">
      <div class="container">

        <div class="section-title">
          <h2>실종 신고 글 수정</h2>
        </div>
        <div class="row">
		<form action="/siljong/modify" method="post" role="form" id="modForm">
          <div class="col-lg-6 center-div">
            <div class="member align-items-start">
              <div class="member-info">
              	<div class="form-group">
	                <label>글번호</label>
	                ${view.sjno }
	            </div>
	            <div class="form-group">
	                <label>작성일</label>
	                <fmt:formatDate value="${view.sjRegDate}" pattern="yyyy-MM-dd"/>
	            </div>
				<div class="form-group">
					<label>제목</label>
					<input type="text" name="sjTitle" class="form-control" value="${view.sjTitle }" required
				        oninput="setCustomValidity('')" oninvalid="setCustomValidity('제목을 입력해주세요.')"></div>
					
				<div class="form-group">
					<label>내용</label>
					<textarea name="sjContent" class="form-control" rows="3" required
				        oninput="setCustomValidity('')" oninvalid="setCustomValidity('내용을 입력해주세요.')">${view.sjContent }</textarea></div>
					
				<div class="form-group">
					<label>실종 상태</label>
					<select name="sjState" class="form-select" style="width: 100px;">
						<option value="실종" ${view.sjState == '실종' ? 'selected' : '' }>실종</option>
						<option value="구조" ${view.sjState == '구조' ? 'selected' : '' }>구조</option>
					</select></div>
					
				<div class="form-group">
					<label>작성자</label>
					<input type="text" name="id" class="form-control" value="${view.id }" readonly></div>
              </div>
            </div>
          </div>
          	<input type="hidden" name="sjno" 	value="${view.sjno }">
          	<input type="hidden" name="pageNum" value="${cri.pageNum }">
			<input type="hidden" name="amount" 	value="${cri.amount }">
			<input type="hidden" name="type" 	value="${cri.type }">
			<input type="hidden" name="keyword" value="${cri.keyword }">
			
          <div class="text-center">
			<sec:authorize access="isAuthenticated()">
			<sec:authentication property="principal" var="p"/>
				<c:if test="${p.username eq view.id || p.username eq 'admin11'}">
					<button data-oper="modify" class="btn upd-btn">수정하기</button>
				</c:if>
			</sec:authorize>
			<!-- 권한에 따라 목록 버튼 보이게 하고 formaction 다르게 지정하기 -->
			<button data-oper="view" class="btn back-btn" formaction="/siljong/view" formmethod="get">뒤로 가기</button>
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		  </div><!-- End col-lg-6 -->
          
          </form>
        </div><!-- End row -->
        
        <!-- 파일 첨부 -->
		 <div class="row">
		     <div class="col-lg-6 center-div">
		         <div class="member align-items-start">
              		<div class="member-info">
		             <h4>사진 등록</h4>
		             <hr>
		             <div class="panel-body">
			            <div class="form-group uploadDiv">
			                <input type="file" class="form-control" name="uploadfile" multiple>
			            </div>   
		                <!-- 업로드 결과 출력 -->
						<div class="uploadResult">
							<ul style="list-style: none; display: flex; flex-wrap: wrap; margin-top: 15px;"></ul>
						</div>
						<!-- 썸네일 원본 이미지 표시 -->
						<div class="originImgDiv">
							<div class="originImg"></div>
						</div>
		             </div>
		             <!-- /.panel-body -->
		         	</div><!-- /.member-info -->
		         </div>
		         <!-- /.member -->
		     </div>
		     <!-- /.col-lg-6 -->
		 </div>
		 <!-- /.row -->
        
      </div><!-- End container -->
    </section><!-- End Doctors Section -->

<%@ include file="../includes/footer.jsp" %>

<script>
var sjTitleInput = $('input[name="sjTitle"]');
var sjContentInput = $('input[name="sjContent"]');

	var form = $('form[role="form"]');
	var sjnoVal = '${view.sjno }';
	
	// 첨부파일 목록 --------------------------
	$.getJSON('/siljong/getAttachList/',		
				{ sjno : sjnoVal },
		function(result){							// 잘 받아와서 성공 시
				console.log(result);				// 첨부파일 리스트 콘솔에 찍어보기
				showUploadFile(result);
		}
	);	// ajax END	
	// 첨부파일 목록 END --------------------
	
	// 1. data-oper="modify"인 수정 버튼 이벤트 막기
	$('button[data-oper="modify"]').on('click', function(e) {
		e.preventDefault();
		
		swal({
	        title: "글을 수정하시겠습니까?",
	        text: "",
	        icon: "warning",
	        buttons: ["취소", "확인"],
	    }).then((willSubmit) => {
	        if (willSubmit) {
	        	// 첨부파일 1개 당 히든태그 4개씩 만들기
	        	var htag = "";
	    		$(".uploadResult ul li").each(function(i, obj){
	    			var hiddenResult = $(obj);
	    			
	    			htag += "<input type = 'hidden' name = 'attachList[" + i + "].fileName' value = '" + hiddenResult.data("filenm")+"'>";
	    			htag += "<input type = 'hidden' name = 'attachList[" + i + "].uuid' value = '" + hiddenResult.data("uuid") + "'>";
	    			htag += "<input type = 'hidden' name = 'attachList[" + i + "].upFolder' value = '" + hiddenResult.data("folder") + "'>";
	    		});
	    		
	    		form.append(htag);
	        	$('#modForm').submit(); // 폼 전송
	        }
	    });
		
// 	    if (confirm('글을 수정하시겠습니까?')) {
// 	        form.submit(); // 폼 전송
// 	    } else {
// 	    	e.preventDefault();
// 	    	return;
// 	    }
	    
	    
		
	});
	
	// 2. 업로드 제한 확인 ---------------------------------
	var regEx = new RegExp("(.*?)\.(exe|sh|zip)$");		// exe|sh|zip의 확장자를 갖고있는 파일은 업로드하지 못함 정규표현식
	var maxSize = 5242880;		
	// 최대 5MB 업로드
	function checkExtension(fileName, fileSize) {
		if (fileSize >= maxSize) {						// 크기 확인 및 알림 메시지 출력 및 업로드 중단
			alert("파일이 너무 커서 업로드 할 수 없습니다!");
			return false;
		}
		if(regEx.test(fileName)) {						// 확장자 확인 및 알림 메시지 출력 및 업로드 중단
			alert("해당 형식의 파일은 업로드 할 수 없습니다!");
			return false;
		} 
		return true;									// 그 외의 경우 업로드
	}
	
	// 3. 첨부파일 선택 이벤트 처리 ----------------------------------
	var csrfHeaderName = "${_csrf.headerName}";			// csrf 토큰 관련 변수
	var csrfTokenValue = "${_csrf.token}";
	
	// 파일 첨부 상태가 변경되었을 때 업로드 + 썸네일 목록 뿌리기
	$('input[name="uploadfile"]').on('change', function() {					// type="file"로 찾아도 가능
		var formData = new FormData();
		var files = $('input[name="uploadfile"]')[0].files;
		console.log(files);
		
		// formData 객체에 파일 추가
		for(var i = 0; i<files.length; i++) {
			// 업로드 제한 사항에 걸리면 폼에 추가 X -> 중단
			if(checkExtension(files[i].name, files[i].size) == false) {		// 위에서 제한 걸려서 false가 오면
				return false;		// 업로드까지 못가고 중단
			} else {
				// 업로드 제한 사항에 안 걸리면 폼에 추가
				formData.append('uploadfile', files[i]);
			}	// if end
		}	// for end
		
		// ajax로 전송
		$.ajax({
			type : 'post',							// get or post
			url : '/upload/ajaxAction',				// 전송할 곳 action
			data : formData,						// 전송할 데이터
			dataType : 'json',						// 수신할 데이터 타입
			contentType : false,					// 컨텐츠 타입 및 인코딩
			processData : false,
			beforeSend : function(xhr) {			// xhr : XML Http Request
				// 전송 전 CSRF 헤더 설정
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			success : function(result, status, xhr) {
					  console.log(result);
					  showUploadFile(result);
			},
			error : function(xhr, status, er) {
				console.log('upload FAIL!');		
			}
		});	// ajax END	
	
	});	// uploadBtn 클릭 이벤트 END
	
	var resultUL = $('.uploadResult ul');
	function showUploadFile(result) {
		if(result == null || result.length == 0) {		// 목록이 없는 경우에 ul 비우기
			resultUL.html('');
			return;
		}
		
	    var liTag = '';  // 변수 초기화
	    for (var i = 0; i < result.length; i++) {
	    	
	    	// li태그 안에 데이터 4가지를 만들어서 보내야됨
	    	liTag += '<li data-uuid="' + result[i].uuid + '" data-filenm="' + result[i].fileName + 
	    			 '" data-folder="' + result[i].upFolder + '" style="margin-right: 20px;">';
	    	
    		// 해당 썸네일 이미지 띄우기
    		var imgSrc = encodeURIComponent(result[i].upFolder + '/s_' + result[i].uuid + '_' + result[i].fileName);
    		var originImg = result[i].upFolder + "\\" + result[i].uuid + "_" + result[i].fileName;	// 원본 이미지 경로 + 파일명
    		originImg = originImg.replace(new RegExp(/\\/g), "/");	// \\ -> /로 변경
    		
    		liTag += '<img src="/display?fileName=' + imgSrc + '"><br>' + result[i].fileName + 
    				 '<button type="button" class="btn btn-warning btn-circle btn-sm" data-file="' + imgSrc + '"' + 
    				 ' data-type="image"> <i class="fa fa-times"></i></button></li>';
	    }
	    resultUL.html(liTag);  				// HTML 내용 적용
	    
	    $('input[name="uploadfile"]').val('');			// 업로드가 성공적으로 되면 input에 파일n개 뜨는거 없애기
	}
	
	// uploadResult안에 있는 span(X)을 클릭했을 때 화면에서 사라지는 이벤트
	$('.uploadResult').on('click', 'button', function(){
		var deleteLi = $(this).closest('li'); 		// 클릭한 버튼이 속한 <li> 요소 선택
		
		swal({
	        title: "첨부 파일을 삭제하시겠습니까?",
	        text: "",
	        icon: "warning",
	        buttons: ["취소", "확인"],
	    }).then((willSubmit) => {
	        if (willSubmit) {
	        	deleteLi.remove();						// DOM에서 지워버리기
	        }
	    });
		
// 		if(confirm('첨부 파일을 삭제하시겠습니까?')){
// 			deleteLi.remove();						// DOM에서 지워버리기
// 		}
		
	});	// 파일 삭제 X 이벤트 END
</script>
