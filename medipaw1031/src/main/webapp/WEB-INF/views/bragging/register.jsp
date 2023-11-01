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
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>


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
	      <h3 class="page-header" style="margin-top: 100px; color:#2C4964; font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif; font-weight: bold;">자랑게시판 > 등록</h3>
	    </div>
	  </div>
<!-- 폼 이어 붙이기 -->
	 <!-- 게시물 상세보기 카드 -->
		  <div class="row mt-3">
		   <form action="/bragging/register" method="post" role="form"> 
		   	<input type="hidden" name="${_csrf.parameterName }"   value="${_csrf.token }">  
		    <div class="col-lg-12">
		      <div class="card border-0 rounded-0">
	               <!-- 게시물 상세 정보 -->               
				        
							 <div class="card-body">
							  <div class="form-group">
							   <label for="title" class="font-weight-bold" style="color:#2C4964; font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;">글쓴이</label>
							    <input type="text" id="id" name="id" class="form-control rounded-30" value='<sec:authentication property="principal.username"/>'  readonly style="background-color: white; color: black;">
							  </div>	
							  <div class="form-group">
							    <label for="title" class="font-weight-bold" style="color:#2C4964; font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;">제목</label>
							    <input type="text" id="title" name="title" class="form-control rounded-30"  style="background-color: white; color: black;">
							    <div class="alert alert-danger mt-2" id="titleAlert" style="display: none;">제목을 입력해주세요.</div>
							</div>            
							<div class="form-group">
							    <label for="content" class="font-weight-bold" style="color:#2C4964; font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;">내용</label>
							    <textarea id="content" name="content" class="form-control rounded-30" rows="3"  style="background-color: white; color: black;"></textarea>
							    <div class="alert alert-danger mt-2" id="contentAlert" style="display: none;">내용을 입력해주세요.</div>
							</div>
							</div>
			            </div> 
			           </div>
					<div class="d-flex justify-content-end">
							<!-- 등록 버튼 -->
							
							<button type="submit" class="btn btn-toss2" style="margin-right: 5px; font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif; font-weight: bold;">
							등록</button> 
							<button type="button" class="btn btn-toss2" style="margin-right: 5px; font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif; font-weight: bold;" onclick="resetFields();">
						    초기화
						</button>
					
							<!-- 목록 버튼 -->
							<button type="button" class="btn btn-toss4" style="font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif; font-weight: bold;"onclick="history.back()">
							목록</button>
						</div>
				
				<!-- </form> -->
					</form>
			</div> <!-- <div class="row mt-3"> -->
</div> <!-- <div class="container"> -->
		<!-- END 게시물 등록 폼 -->
	      
	  <!-- 폼 이어붙이기 END -->
<!-- 첨부 파일 ------------------------------->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                Attach File
            </div>	<!-- /.panel-heading -->
            <div class="panel-body">
				<div class="form-group uploadDiv">
					<input type="file" name="uploadFile" multiple>
				</div>
				
				<!-- 업로드 결과 출력 -->
				<div class="uploadResult">
					<ul> </ul>
				</div>
					<!-- END 업로드 결과 출력 -->
            </div>	<!-- /.panel-body -->
        </div>  	<!-- /.panel -->
    </div>      	<!-- /.col-lg-12 -->
</div>    			<!-- /.row -->
<!-- END 첨부 파일 --------------------------->
 <!-- 붙여넣기 end -->

<script>
//첨부파일 선택 이벤트 처리 -----------------
var csrfHeaderName = '${_csrf.headerName}';	//CSRF 토큰 관련 변수
var csrfTokenValue = '${_csrf.token}';		//
	
	function resetFields() {
	    document.getElementById('title').value = '';
	    document.getElementById('content').value = '';
	    // 초기화 버튼 누를시 제목 내용만 지우기 
	}
	
	var frm = $('form[role="form"]');
	
	//submit 버튼 이벤트 처리 -----------------
	$('button[type="submit"]').on('click', function(e){
	    e.preventDefault();
	    
	    var title = $("#title").val();
	    var content = $("#content").val();

	    if(title == ""){
	        $("#titleAlert").show();
	        return; // 추가된 부분: 제목이 비어있으면 여기서 함수 종료
	    } else {
	        $("#titleAlert").hide();
	    }

	    if(content == ""){
	        $("#contentAlert").show();
	        return; // 추가된 부분: 내용이 비어있으면 여기서 함수 종료
	    } else {
	        $("#contentAlert").hide();
	    }

	    var hiddenTag = '';
	    
	    $('.uploadResult ul li').each(function(i, obj){
	        hiddenTag += '<input type="hidden" name="brAttachList[' + i + '].uuid" ' + 
	                           ' value="' + $(obj).data('uuid') + '">';
	                           
	        hiddenTag += '<input type="hidden" name="brAttachList[' + i + '].uploadPath" ' + 
	                           ' value="' + $(obj).data('uploadph') + '">';
	       
	        hiddenTag += '<input type="hidden" name="brAttachList[' + i + '].fileName" ' + 
	                           ' value="' + $(obj).data('filenm') + '">';
	       
	        hiddenTag += '<input type="hidden" name="brAttachList[' + i + '].fileType" ' + 
	                           ' value="' + $(obj).data('filetp') + '">';
	    });      
	    console.log(hiddenTag);
	    frm.append(hiddenTag);
	    frm.submit();
	});//END submit 버튼 이벤트 처리 -------------
	
	
	//업로드 제한 확인 ------------------------
 	var regEx = new RegExp("(.*?)\.(exe|sh|zip)$");  
	var maxSize = 5242880;

	function checkExtension(fileName, fileSize) { 
		 if (fileSize > maxSize) { 
			alert("파일 크기(5MB)가 초과하여 업로드 할 수 없습니다.");
			return false;
		} 
		
		if (regEx.test(fileName)) { 
			alert("해당 형식의 파일은 업로드 할 수 없습니다.");
			return false;
		} 
		
		return true;	 
	}//END 업로드 제한 확인 --------------------
	
	
	$('input[type="file"]').on('change', function() {
		var formData = new FormData();
		var files = $('input[name="uploadFile"]')[0].files;
		
		 // 기존 첨부파일 갯수 확인
	    var existingFiles = $('.uploadResult ul li').length;

	    // 기존 첨부파일 갯수와 새로 업로드할 파일의 수가 4를 초과하는지 확인
	    if (existingFiles + files.length > 3) {
	        alert("첨부파일은 총 3개까지만 가능합니다.");
	        $(this).val(''); // 선택한 파일 초기화
	        return false;
	    }

		//formData 객체에 파일 추가
		for (var i = 0; i < files.length; i++) {
			if (!checkExtension(files[i].name, files[i].size)) { 
				return false;
			} else {
				formData.append('uploadFile', files[i]);
			}
		}

		 $.ajax({
		        type : 'post',
		        url : '/bragging/upload/ajaxAction',
		        data : formData,
		        dataType : 'json',
		        contentType : false,
		        processData : false,
		        
		        beforeSend : function(xhr) {
		            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		           // 시큐리티
		        },
		        
		        success : function(result, status, xhr) {
		            $('input[type="file"]').val(""); 
		            showUploadedFile(result); 
		            console.log("upload success");
		       }, //성공시
		       
		       error: function(xhr, status, er) {
		           console.log("upload error");
		           console.log(er);
		           console.log(error);
		       } //에러시
		    }); 
		});

		//업로드 결과 출력 ----------------------------------------------
		var resultUL = $('.uploadResult ul');  
		function showUploadedFile(result){  
		    var liTag = '';

		    $(result).each(function(i, obj){  

		         liTag += '<li data-uuid="' + obj.uuid + '" ' + 
		                     ' data-uploadph="' + obj.uploadPath + '" ' +
		                     ' data-filenm="' + obj.fileName + '" ' +
		                     ' data-filetp="' + obj.fileType+ '">';

		         if(obj.fileType){
		             var thumbImg = encodeURIComponent(
		                                 obj.uploadPath+ "/s_" +
		                                 obj.uuid+ "_" +
		                                 obj.fileName);

		             var originImg = obj.uploadPath+ "\\" +
		                             obj.uuid+ "_" +
		                             obj.fileName; 	
		             originImg = originImg.replace(new RegExp(/\\/g), "/"); 

		             liTag += '<img src="/bragging/display?fileName='+ thumbImg +'"></a><br>' +
		                        	obj.fileName+
		                         '<button type="button" class="btn btn-warning btn-circle" '+
		                         	' data-file="' + thumbImg+'" '+
		                         	' data-type="'+obj.fileType+'"> '+
		                         '<i class="fa fa-times"></i></button></li>';						 
		         } else { 		
		             var filePath= encodeURIComponent(
		                             	obj.uploadPath+"/"+ 
		                             	obj.uuid+"_"+ 
		                             	obj.fileName);
		             
		             liTag += '<img src="/resources/img/attach.png"></a><br>'+ 
		                     	 	 	obj.fileName+
		                         '<button type="button" class="btn btn-warning btn-circle btn-xs" '+
		                 	 	 		' data-file="'+filePath+'" '+
		                 	      		' data-type="'+obj.fileType+'"> '+
		                 	       '<i class="fa fa-times"></i></button></li>';	
		         }
		     });
		     resultUL.append(liTag);  
		}

		
		
	//X 버튼 클릭 이벤트 처리 -----------------------------------------
	$('.uploadResult').on('click', 'button', function() {
		var x = $(this).closest('li');
		
		$.ajax({
			type : 'post',				 
			url : '/bragging/deleteFile', 		 
			data : { fileName : $(this).data('file'), 
					 type     : $(this).data('type')  },			 
			dataType : 'text', 		
			beforeSend : function(xhr){	//xhr ; XML Http Request
				//전송 전 CSRF 헤더 설정
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			// 시큐리티
			}, 
			success : function(result, status, xhr) {
						alert(" 첨부파일 선택을 취소하였습니다 ");
						x.remove();
			}, //성공시
			error : function(xhr, status, er) {
				console.log("delete error");
				console.log(error);
			} //에러시
		}); //END ajax;
	});
	//END X 버튼 클릭 이벤트 처리 -------------------------------------
	
	
</script> 
<%@ include file="../includes/footer.jsp" %>	



