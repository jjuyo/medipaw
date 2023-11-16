<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src= "https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="/resources/js/animalAddr_ver2.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<div class="row">
    <div class="col-lg-12">
        <h3 class="page-header">View</h3>
    </div>	<!-- /.col-lg-12 -->
</div>		<!-- /.row -->

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-body">
            <!-- 게시물 등록 폼 -->
			<!-- <form action="/board/register" method="post" role="form"> -->
				<div class="form-group">
					<label>Writer</label>
					<input type="text" name="writer" class="form-control"
						   value="${nvo.note_sender }" readonly></div>
				<div class="form-group">
					<div class="pull-right">
					작성일 :
					</div>
					<input type="text" name="nno" class="form-control" pattern="yyyy-MM-dd (E)"
						   value="${nvo.note_date}" readonly>
				</div>
			
				<div class="form-group">
					<label>Title</label>
					<input type="text" name="title" class="form-control"
						   value="${nvo.note_title }" readonly></div>
					
				<div class="form-group">
					<label>Content</label>
					<textarea name="content" class="form-control"
							  rows="3" readonly>${nvo.note_content }</textarea></div>
					
			<form>
			    <input type="hidden" name="bno" value="${nvo.note_no}">
			    
				<input type="hidden" name="id" class="form-control" id="id" value='<sec:authentication property="principal.username"/>'>
				<c:choose>
				    <c:when test="${nvo.note_sender eq pageContext.request.userPrincipal.name && nvo.note_sender_status eq 2}">
				        <button id="unupdateBtn" class="btn btn-warning">
				            보관 해제
				        </button>
				    </c:when>
				    <c:when test="${nvo.note_recipient eq pageContext.request.userPrincipal.name && nvo.note_recipient_status eq 2}">
				        <button id="unupdateBtn" class="btn btn-warning">
				            보관 해제
				        </button>
				    </c:when>
				    <c:otherwise>
				        <button id="updateBtn" class="btn btn-warning">
				            보관
				        </button>
				    </c:otherwise>
				</c:choose>
				<c:choose>
				<c:when test="${nvo.note_recipient eq pageContext.request.userPrincipal.name}">
					<button type="button" id="reSendBtn" class="btn btn-warning">
					    답장
					</button>
			    </c:when>
			    </c:choose>
			    <button id="deleteBtn" class="btn btn-primary" >
			        삭제
			    </button>
			</form>
			<!-- </form> -->
            <!-- END 게시물 등록 폼 -->
            </div>	<!-- /.panel-body -->
        </div>  	<!-- /.panel -->
    </div>      	<!-- /.col-lg-12 -->
</div>    			<!-- /.row -->
<script>
//보관 버튼 클릭 시 처리
$('#updateBtn').on('click', function() {
    var bno = $('input[name="bno"]').val();
    $.ajax({
        type: 'GET',
        url: '/note/noteSave',
        data: { note_no: bno },
        success: function(response) {
        	alert("쪽지를 보관했습니다.");
        	window.close();
        },
        error: function(jqXHR, textStatus, errorThrown) {
        	 alert("오류가 발생했습니다. 다시 시도해주세요."); 
        }
    });
});

$('#unupdateBtn').on('click', function() {
    var bno = $('input[name="bno"]').val();
    $.ajax({
        type: 'GET',
        url: '/note/noteUnSave',
        data: { note_no: bno },
        success: function(response) {
        	alert("쪽지를 보관 해제 했습니다.");
        	window.close();
        },
        error: function(jqXHR, textStatus, errorThrown) {
        	 alert("오류가 발생했습니다. 다시 시도해주세요."); 
        }
    });
});
// 삭제 버튼 클릭 시 처리
$('#deleteBtn').on('click', function() {
    var bno = $('input[name="bno"]').val();
    $.ajax({
        type: 'GET',
        url: '/note/noteDelete',
        data: { note_no: bno },
        success: function(response) {
        	alert("쪽지를 삭제했습니다.");
        	window.close();
            location.reload();
        },
        error: function(jqXHR, textStatus, errorThrown) {
        	 alert("오류가 발생했습니다. 다시 시도해주세요."); 
        }
    });  
});
$(document).ready(function() {
    $('#reSendBtn').on('click', function() {
        console.log(1);
        var bno = $('input[name="bno"]').val();
        var recipientId = "${nvo.note_sender}";
        var title = encodeURIComponent("[re:" + bno + "]");
        window.location.href = '/note/resend?bno=' + bno + '&userId=' + recipientId + '&title=' + title;
    });
});
</script>













