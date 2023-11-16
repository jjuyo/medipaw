<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src= "https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="/resources/js/animalAddr_ver2.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>    
<div class="row">
    <div class="col-lg-12">
        <h2 class="page-header">쪽지 전송 Form</h2>
    </div>	<!-- /.col-lg-12 -->
</div>		<!-- /.row -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-body">         	
				<form action="/note/register" method="post" role="form">
					<div class="form-group">
						<label>받을 상대:</label>
					<input type="text" name="note_recipient" class="form-control"
						   value="${userId}" readonly></div>
				<div class="form-group">
					<label>제목:</label>
					<input type="text" name="note_title" class="form-control" value="${note_title}"></div>
					
				<div class="form-group">
					<label>내용:</label>
					<textarea name="note_content" class="form-control"
							  rows="3"></textarea></div>
					<button type="button" class="btn btn-warning" onclick="history.back()">Cancel</button>
					<button type="submit" class="btn btn-primary">Submit</button>
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
				</form>
            	<!-- END 게시물 등록 폼 -->
            </div>	<!-- /.panel-body -->
        </div>  	<!-- /.panel -->
    </div>      	<!-- /.col-lg-12 -->
</div>    			<!-- /.row -->

<script>
	var frm = $('form[role="form"]');
	//submit 버튼 이벤트 처리 -----------------
	$('button[type="submit"]').on('click', function(e){
		e.preventDefault(); // 이 부분 추가
		// AJAX를 이용한 데이터 전송
		$.ajax({
			type: frm.attr('method'),
			url: frm.attr('action'),
			data: frm.serialize(),
			success: function (data) {
				alert("전송 성공");
				window.close();
			},
			error: function (jqXHR, textStatus, errorThrown) {
				alert("An error occurred: " + textStatus, errorThrown);
			}
		});
	});
</script>

















