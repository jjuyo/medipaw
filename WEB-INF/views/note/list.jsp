<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<!-- Bootstrap CSS -->
<style>
    body {
        padding-top: 80px; /* 헤더의 높이만큼 상단 패딩 추가 */
    }
    .move-black {
    color: black;
}
</style>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src= "https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="/resources/js/animalAddr_ver2.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<div class="row" >
    <div class="col-lg-12">
        <h3 class="page-header">Note List Page</h3>
    </div>
</div><br>
<div class="container">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                 <button id="regBtnRecp" type="button" class="btn btn-xs pull-right btn-info">
                    받은 쪽지함
                </button>
                <button id="regBtnSend" type="button" class="btn btn-xs pull-right btn-info">
                    보낸 쪽지함
                </button>
                <button id="regBtnSave" type="button" class="btn btn-xs pull-right btn-info">
                    쪽지 보관함
                </button>
            </div> <!-- /.panel-heading -->
            <div class="panel-body">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>제목</th>
                            <th>작성자</th>
                            <th>작성일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Model 데이터 출력 -->
                        <c:forEach items="${list}" var="note">
                            <tr>
                                <td>${note.note_no}</td>
                                <td>
                                	<input type="hidden" class="note-recipient" value="${note.note_recipient}">
           						 	<input type="hidden" class="note-recipient-status" value="${note.note_recipient_status}">
            						<input type="hidden" class="note-sender" value="${note.note_sender}">
           						 	<input type="hidden" class="note-sender-status" value="${note.note_sender_status}">
                                <c:choose>
                					<c:when test="${note.note_sender eq pageContext.request.userPrincipal.name && note.note_sender_status eq 0}">
	                                    <a class="move" href="${note.note_no}">
	                                        ${note.note_title}
	                                    </a>
                                    </c:when>
                                    <c:when test="${note.note_recipient eq pageContext.request.userPrincipal.name && note.note_recipient_status eq 0}">
                                   	     <a class="move" href="${note.note_no}">
	                                        ${note.note_title}
	                                    </a>
                                   </c:when>
                				   <c:otherwise>
                				   		<a class="move move-black" href="${note.note_no}">
                        					${note.note_title}
                    					</a>
                				   </c:otherwise>
            				</c:choose>
                                </td>
                                <td>${note.note_sender}</td>
                                <td><fmt:formatDate value="${note.note_date}" pattern="yyyy-MM-dd"/></td>
                            </tr>
                        </c:forEach>
                        <!-- END Model 데이터 출력 -->
                    </tbody>
                </table> <!-- /.table-responsive -->          
                <div class="pull-right d-flex justify-content-center">
                    <div class="col-lg-12">
                        <!-- 검색 타입 및 검색 키워드 -->
                        <form  id="searchFrm">
                            <select name="type">
                                <c:set var="type" value="${pageDTO.cri.type}"/>
                                <option value="T" ${type == 'T' ? 'selected' : ''}>제목</option>
                                <option value="C" ${type == 'C' ? 'selected' : ''}>내용</option>
                                <option value="W" ${type == 'W' ? 'selected' : ''}>작성자</option>
                            </select>
                            <input type="text" name="keyword" value="${pageDTO.cri.keyword}">
                            <button class="btn btn-default btn-sm searchBtn">검색</button>
                            
                            <!-- 페이지 번호와 페이지에 표시할 게시물의 수 -->
                            <input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum}">
                            <input type="hidden" name="amount" value="${pageDTO.cri.amount}">
                        </form>
                        <!-- END 검색 타입 및 검색 키워드 -->
                    </div>
                </div>                
                <!-- paging -->
                <div class="pull-right">
                    <ul class="pagination">
                        <%-- 이전 버튼 --%>
                        <c:if test="${pageDTO.prev}">
                            <li class="page-item">
                                <a href="${pageDTO.start - 1}" class="page-link">&laquo; Previous</a>
                            </li>
                        </c:if>
                        
                        <%-- 페이지 번호 버튼 --%>
                        <c:forEach begin="${pageDTO.start}" end="${pageDTO.end}" var="i">
                            <%-- <c:url var="link" value=""/> --%>
                            <li class="page-item ${pageDTO.cri.pageNum == i ? 'active' : ''}">
                                <a href="${i}" class="page-link">${i}</a>
                            </li>
                        </c:forEach>
                        
                        <%-- 다음 버튼 --%>
                        <c:if test="${pageDTO.next}">
                            <li class="page-item">
                                <a href="${pageDTO.end + 1}" class="page-link">Next &raquo;</a>
                            </li>
                        </c:if>
                    </ul>
                </div>
                <!-- END paging -->
                
                <!-- 현재 페이지 번호 및 출력 게시물 수, 검색 타입, 키워드 전송 폼 -->
                <form action="/note/list" id="actionFrm">
                    <input type="hidden" name="type" value="${pageDTO.cri.type}">
                    <input type="hidden" name="keyword" value="${pageDTO.cri.keyword}">
                    <input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum}">
                    <input type="hidden" name="amount" value="${pageDTO.cri.amount}">
                </form>
            </div> <!-- /.panel-body -->
        </div> <!-- /.panel -->
    </div> <!-- /.col-lg-12 -->
</div> <!-- /.row -->
 
<script>
$(function(){
	var searchFrm = $('#searchFrm');
	$('.searchBtn').on('click', function() {
	    searchFrm.find("input[name='pageNum']").val('1');
	    var selectedType = searchFrm.find("select[name='type']").val();
	    var newAction = '';
	    
	    if (selectedType === 'T') {
	        newAction = '/note/selectSend';
	    } else if (selectedType === 'C') {
	        newAction = '/note/selectRecp';
	    } else if (selectedType === 'W') {
	        newAction = '/note/selectSave';
	    }
	    
	    searchFrm.attr('action', newAction);
	    searchFrm.submit();
	});
	
var actionFrm = $('#actionFrm');	
$('.page-item a').on('click', function(e){
    e.preventDefault();
    var pageNum = $(this).attr('href');
    
    var currentPath = window.location.pathname; // 현재 페이지의 경로를 가져옴

    // 현재 페이지의 경로에 따라 요청을 보낼 URL을 결정
    var url;
    if (currentPath.includes('selectSend')) {
        url = '/note/selectSend';
    } else if (currentPath.includes('selectRecp')) {
        url = '/note/selectRecp';
    } else if (currentPath.includes('selectSave')) {
        url = '/note/selectSave';
    } else {
        // 예상치 못한 경로일 경우 처리
        console.error('Unexpected path:', currentPath);
        return;
    }

    actionFrm.attr('target', '_self');
    actionFrm.attr('action', url); // 수정된 부분
    actionFrm.find("input[name='pageNum']")
             .val(pageNum);
    actionFrm.submit();
});
	//END 페이징 이벤트 처리 --------------------------
	
	//게시물 제목 클릭 이벤트 처리 -----------------------
$('.move').on('click', function(e){
    e.preventDefault();    
    var url = $(this).attr('href'); // 팝업 창에 표시할 URL
    actionFrm.append("<input type='hidden' name='nno' value='" + url + "'>");
    var popupOptions = 'width=500,height=500,scrollbars=yes,resizable=yes';
    var popupWindow = window.open('view.jsp', 'note', popupOptions);
    actionFrm.attr('target', 'note');
    actionFrm.attr('action', '/note/view');
    actionFrm.submit();
    actionFrm.find("input[name='nno']").remove();

    var noteRecipient = $(this).siblings('.note-recipient').val();
    var noteRecipientStatus = $(this).siblings('.note-recipient-status').val();
    var noteSender = $(this).siblings('.note-sender').val();
    var noteSenderStatus = $(this).siblings('.note-sender-status').val();
    var userName = '${pageContext.request.userPrincipal.name}';
    
    if (((noteRecipient == userName) && (noteRecipientStatus == 2 || noteRecipientStatus == 3)) &&
    	    ((noteSender == userName) && (noteSenderStatus == 2 || noteSenderStatus == 3))) {
    	console.log("true");
    } else {
        $.ajax({
            type: 'GET',
            url: '/note/noteCheck',
            data: { note_no: url }, // 클릭한 링크의 URL을 사용하여 데이터 전달
            success: function(response) {
                console.log("success");
                location.reload();
            }, 
            error: function(jqXHR, textStatus, errorThrown) {
                alert("오류가 발생했습니다. 다시 시도해주세요.");
            }
        });
    }
});
	
	
	

$('#regBtnSend').on('click', function() {
    location.href = '/note/selectSend';
});

$('#regBtnRecp').on('click', function() {
    location.href = '/note/selectRecp';
});

$('#regBtnSave').on('click', function() {
    location.href = '/note/selectSave';
});
	
	//END 게시물 제목 클릭 이벤트 처리 -------------------
});//END $
</script>
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>















