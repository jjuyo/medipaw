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

.form-control {
            width: 60%; /* Set the width to 50% of the container */
            padding: 10px;
            margin: 5px 0;
            border-radius: 4px;
             justify-content: center;
             display: flex;
        }
</style>
</head>

<body>
<div class="container">
   <br><br><br><br><br><br><br>
 <div class="section-title">
          <h2>분양 글 작성</h2>
        </div>
     <div>
            <label for="byImg">대표사진(*필수)</label>
            <input type="file" name="byImg" class="form-control" required>
           <img src="" id="byImg" style="display: none;">

        </div>
   <form method="post"  action="/boonyang/write" role="form">
   <div>
    <label for="id">작성자*</label>
   <input type="text" name="id" class="form-control" 
					value='<sec:authentication property="principal.mvo.id"/>' readonly style="background-color: lightgray;"></div>
      <div>
            <label for="title">제목*</label>
            <input type="text" id="title" name="title" class="form-control" required>
        </div>
        <div>
            <label for="kind">동물종* </label>
            <input type="text" id="kind" name="kind" class="form-control" required>
        </div>
        	<label for="gender">성별*</label>　
        <input type="radio" name="gender" value="암컷" required>암컷　
		<input type="radio" name="gender" value="수컷" required>수컷
        <div>
   <div>
    <label for="age">나이*</label>　
    <input type="number" id="age" name="age" class="form-control" style="width: 100px; display: inline-block;" required> 세
</div>


</div>

         <div>
			<label>내용*</label>
			<textarea name="content" class="form-control"
							  rows="3" required></textarea></div>
         
	<input type="hidden" name="state" value="분양중" id="state">   
       
        <hr class="my-4">
        <div class="button-container">
    <div class="form-group row mt-4">
        <div class="col text-center">
            <button type="submit" class="btn btn-info regBtn" style="width:70px;" >등록</button>
        </div>
        <div class="col text-center">
            <button class="btn btn-secondary cancelBtn" onclick="goBack()" type="button">취소</button>
        </div>
    </div>
</div>
   <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
   <input type="hidden"  id="img"  name="byImg" value=""/>
    </form>
    </div>
    
    <!-- 파일 첨부 -->
		 <div class="row"  style="margin-left:50px;">
		     <div class="col-lg-6 center-div">
		         <div class="member align-items-start">
              		<div class="member-info">
		             <h4>추가사진 등록(선택)</h4>
		             <hr>
		             <div class="panel-body">
			            <div class="form-group uploadDiv">
			                <input type="file" name="uploadfile" multiple >
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
    
  </body>    

<script>
var frm = $('form[role="form"]');
$('button[type="submit"]').on('click', function(e) {
    e.preventDefault();

    // 유효성 검사를 수행할 input 필드를 선택합니다.
    var requiredInputs = $('input[required], textarea[required]');

    // 모든 requiredInputs를 순회하며 유효성 검사를 수행합니다.
    var isValid = true;
    requiredInputs.each(function() {
        if ($(this).val() === '') {
            isValid = false;
        }
    });

    if (isValid) {
        var str = '';
        $('.uploadResult ul li').each(function(i, obj) {
            var aobj = $(obj);
            str += '<input type="hidden" name="attachList[' + i + '].fileName" value="' + aobj.data('filenm') + '">';
            str += '<input type="hidden" name="attachList[' + i + '].uuid" value="' + aobj.data('uuid') + '">';
            str += '<input type hidden" name="attachList[' + i + '].upFolder" value="' + aobj.data('folder') + '">';
            str += '<input type="hidden" name="attachList[' + i + '].image" value="' + aobj.data('image') + '">';
        });

        frm.append(str);
        frm.submit();
    } else {
        alert("*필수입력란을 모두 작성해주세요");
    }
});

//첨부파일 선택 이벤트 처리 -----------------
var csrfHeaderName = '${_csrf.headerName}';
var csrfTokenValue = '${_csrf.token}';
// 파일 첨부 상태가 변경되었을 때 업로드 + 썸네일 목록 뿌리기
$('input[name="uploadfile"]').on('change', function() {					// type="file"로 찾아도 가능
	var formData = new FormData();
	var files = $('input[name="uploadfile"]')[0].files;
	console.log(files);
	
	// formData 객체에 파일 추가
	for(var i = 0; i<files.length; i++) {
			formData.append('uploadfile', files[i]);
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
//			beforeSend : function(xhr) {				// xhr : XML Http Request
//				// 전송 전 CSRF 헤더 설정
//				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
//			},
		success : function(result, status, xhr) {	// 성공적으로 삭제된 경우
				console.log(result);
				deleteLi.remove();					// DOM에서도 지워버리기
		},
		error : function(xhr, status, er) {
			console.log('delete FAIL!');		
		}
	});	// ajax END	
	
});	// 파일 삭제 X 이벤트 END
function goBack() {
    history.back();
}

  $('input[name="byImg"]').on('change', function() {
    var formData = new FormData();
    var file = $('input[name="byImg"]')[0].files[0]; // 파일을 선택

    formData.append('img', file); // 파일을 FormData에 추가

    $.ajax({
        type: 'post',
        url: '/upload/ajaxAction2',
        data: formData, // FormData를 데이터로 사용
        dataType: 'json',
        processData: false, // false로 설정하여 FormData를 변환하지 않도록 함
        contentType: false, // false로 설정하여 컨텐트 타입을 설정하지 않도록 함
        beforeSend: function(xhr){
            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
        },
        success: function(result, status, xhr) {
            console.log(result.uuid+"_"+result.fileName);
            $("#img").val(result.uuid+"_"+result.fileName);
            $('#byImg').attr('src', '../resources/img/medipaw/'+result.uuid+"_"+result.fileName);
            $('#byImg').show(); 
        },
        error: function(xhr, status, er) {
            console.log("upload error");
        }
    });
}); 
 
</script>


<%@ include file="/WEB-INF/views/includes/footer.jsp" %>