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
  .appointment-btn {
  border: none; /* 테두리 없애기 */
  margin-top: 10px;
  margin-bottom: 10px;
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
  margin-bottom: 10px;
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

<!-- ======= Doctors Section ======= -->
    <section id="doctors" class="doctors with-margin">
      <div class="container">

        <div class="section-title">
          <h2>실종 신고 글 등록</h2>
        </div>
        <div class="row">
		<form action="/siljong/register" method="post" role="form" id="regFrm">
          <div class="col-lg-6 center-div">
            <div class="member align-items-start">
              <div class="member-info">
                <div class="form-group">
					<label>제목</label>
					<input type="text" name="sjTitle" class="form-control" required
				        oninput="setCustomValidity('')" oninvalid="setCustomValidity('제목을 입력해주세요.')"></div>
					
				<div class="form-group">
					<label>내용</label>
					<textarea name="sjContent" class="form-control" rows="5" required
				        oninput="setCustomValidity('')" oninvalid="setCustomValidity('내용을 입력해주세요.')"></textarea></div>
					
				<div class="form-group">
					<label>작성자</label>
					<input type="text" name="id" class="form-control" value="<sec:authentication property="principal.mvo.id"/>" readonly></div>
              </div>
            </div>
          </div>
          <div class="text-center">
          <button type="button" class="back-btn" onclick="history.back()">돌아가기</button>
          <button type="submit" class="appointment-btn">등록하기</button></div>
          <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
          </form>
        </div>

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
var sjContentInput = $('textarea[name="sjContent"]');

var form = $('form[role="form"]');
	
	// 1. submit 이벤트 막기
	$('button[type="submit"]').on('click', function(e) {
		e.preventDefault();
		
		if (sjTitleInput.val().trim() === '' || sjContentInput.val().trim() === '') {
	        return;  // 필드가 비어있으면 폼 제출을 막음
	    }

		swal({
	        title: "글을 등록하시겠습니까?",
	        text: "",
	        icon: "warning",
	        buttons: ["취소", "확인"],
	    }).then((willSubmit) => {
	        if (willSubmit) {
	        	// 첨부파일 1개 당 히든태그 4개씩 만들기
	    		var htag = "";
	    		$(".uploadResult ul li").each(function(i, obj){
	    			var hiddenResult = $(obj);
	    			
	    			htag += "<input type = 'hidden' name = 'attachList[" + i + "].fileName' value = '" + hiddenResult.data("filenm") + "'>";
	    			htag += "<input type = 'hidden' name = 'attachList[" + i + "].uuid' value = '" + hiddenResult.data("uuid") + "'>";
	    			htag += "<input type = 'hidden' name = 'attachList[" + i + "].upFolder' value = '" + hiddenResult.data("folder") + "'>";
	    		});
	    		
	    		form.append(htag);
	        	form.submit(); 		// 폼 전송
	        }
	    });

		
// 	    if (confirm('글을 등록하시겠습니까?')) {
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
	    	
	    	// li태그 안에 데이터 3가지를 만들어서 보내야됨
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
	
	// uploadResult안에 있는 span(X)을 클릭했을 때 파일 삭제되는 이벤트
    $('.uploadResult').on('click', 'button', function(){
    	var file = $(this).data('file');
    	var type = $(this).data('type');
    	var deleteLi = $(this).closest('li'); 		// 클릭한 버튼이 속한 <li> 요소 선택
		
		$.ajax({
			type : 'post',								// get or post
			url : '/deleteFile',						// 전송할 곳 action
			data : {fileName: file, type: type},		// 전송할 데이터
			dataType : 'text',							// 수신할 데이터 타입
			beforeSend : function(xhr) {				// xhr : XML Http Request
				// 전송 전 CSRF 헤더 설정
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			success : function(result, status, xhr) {	// 성공적으로 삭제된 경우
					console.log(result);
					deleteLi.remove();					// DOM에서도 지워버리기
			},
			error : function(xhr, status, er) {
				console.log('delete FAIL!');		
			}
		});	// ajax END	
		
    });	// 파일 삭제 X 이벤트 END
</script>
