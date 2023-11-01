<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원관리</title>
    <style>
        /* Custom CSS for centering and design */
        .center-contents {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        .search-bar {
            display: flex;
            justify-content: center;
            margin: 20px 0;
        }

        .pagination-container {
            display: flex;
            justify-content: center;
        }
    </style>
</head>
<body>
<%@ include file="../includes/header.jsp" %>
<br><br><br><br>
<div class="center-contents" >
        <div class="panel panel-default" style="width: 60%;">
            <div class="panel-heading">
                Member List Page
            </div>
            <div class="panel-body">
            <br><br>
                <table class="table table-hover" >
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>NAME</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Model 데이터 출력 -->
                        <c:forEach items="${list }" var="mvo">
                            <tr>
                                <td><a class="move" href="${mvo.id}">${mvo.id}</a></td>
                                <td>${mvo.name}</td>
                            </tr>
                        </c:forEach>
                        <c:choose>
    <c:when test="${empty list}">
        <tr>
            <td colspan="2">검색결과가 없습니다.</td>
        </tr>
    </c:when>
</c:choose>
                        <!-- END Model 데이터 출력 -->
                    </tbody>
                </table>

                <div class="search-bar">
                    <form action="/member/list" id="searchFrm">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        <select name="type" class="custom-select" id="inputGroupSelect02">
                            <c:set var="type" value="${pageDTO.cri.type}" />
                            <option value="I" ${type == 'I' ? 'selected' : ''}>아이디</option>
                            <option value="N" ${type == 'C' ? 'selected' : ''}>이름</option>
                            <option value="IN" ${type == 'IN' ? 'selected' : ''}>아이디 or 이름</option>
                        </select>
                        <input type="text" name="keyword" value="${pageDTO.cri.keyword}">
                        <button class="btn btn-default btn-sm searchBtn">검색</button>
                        <button class="btn btn-default btn-sm cancelBtn" style="display: none;">목록</button>
                        
                        <input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum}">
                        <input type="hidden" name="amount" value="${pageDTO.cri.amount}">
                    </form>
                </div>

                <div class="pagination-container">
                    <ul class="pagination">
                        <c:if test="${pageDTO.prev}">
                            <li class="page-item">
                                <a href="${pageDTO.start - 1}" class="page-link">&laquo; Previous</a>
                            </li>
                        </c:if>
                        <c:forEach begin="${pageDTO.start}" end="${pageDTO.end}" var="i">
                            <li class="page-item ${pageDTO.cri.pageNum == i ? 'active' : ''}">
                                <a href="${i}" class="page-link">${i}</a>
                            </li>
                        </c:forEach>
                        <c:if test="${pageDTO.next}">
                            <li class="page-item">
                                <a href="${pageDTO.end + 1}" class="page-link">Next &raquo;</a>
                            </li>
                        </c:if>
                    </ul>
                </div>

                <form action="/member/list" id="actionFrm">
                    <input type="hidden" name="type" value="${pageDTO.cri.type}">
                    <input type="hidden" name="keyword" value="${pageDTO.cri.keyword}">
                    <input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum}">
                    <input type="hidden" name="amount" value="${pageDTO.cri.amount}">
                </form>
            </div>
        </div>
</div>
<%@ include file="../includes/footer.jsp" %>
</body>

<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

<script>



$(function(){
    $('.cancelBtn').show();

	$('.cancelBtn').on('click', function(){
	    // 키워드 입력 필드를 비우고 페이지 번호를 초기화합니다.
	    searchFrm.find("input[name='keyword']").val('');
	    searchFrm.find("input[name='pageNum']").val('1');
	    
	    // 폼을 제출하여 페이지를 갱신합니다.
	    searchFrm.submit();
	});
	
	//검색 버튼 이벤트 처리 ---------------------------
	var searchFrm = $('#searchFrm')
	
	$('.cancelBtn').on('click', function(){
	    // 키워드 입력 필드를 비우고 페이지 번호를 초기화합니다.
	    searchFrm.find("input[name='keyword']").val('');
	    searchFrm.find("input[name='pageNum']").val('1');
	    
	    // 폼 제출하여 페이지 갱신
	    searchFrm.submit();

	     //취소버튼 숨기기
});
	
	$('.searchBtn').on('click', function(){
		//검색 키워드를 입력하지 않은 경우
// 		if(searchFrm.find("input[name='keyword']").val() == ''){
// 			alert('검색 키워드를 입력해 주세요.');
// 			return false;
// 		}
		
		//검색 시 페이지 번호를 1이 되도록 설정
		searchFrm.find("input[name='pageNum']")
		 		 .val('1');
		searchFrm.submit();

	});	
	//END 검색 버튼 이벤트 처리 -----------------------
	
	//페이징 이벤트 처리 ------------------------------
	var actionFrm = $('#actionFrm');
	
	$('.page-item a').on('click', function(e){
		e.preventDefault();
		
		//a 태그의 href 값을 pageNum에 저장
		actionFrm.find("input[name='pageNum']")
				 .val($(this).attr('href'));
		
		actionFrm.submit();
	});
	//END 페이징 이벤트 처리 --------------------------
	
	//회원 id 클릭 이벤트 처리 -----------------------
$('.move').on('click', function(e){
    e.preventDefault();
    var userId = $(this).attr('href');
    window.location.href = "/member/view/" + userId;
});
	//END 게시물 제목 클릭 이벤트 처리 -------------------
	

});//END $
</script>