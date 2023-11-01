<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
  .with-margin {
    margin-top: 100px;
  }
  .pagination-container {
    display: flex;
    justify-content: center;
    margin-top: 20px;
  }
  .pagination {
    list-style: none;
    display: flex;
    padding: 0;
    margin: 0;
  }
  .custom-pagination .page-item.active .page-link {
	border-color : #1977cc;
    background-color: #1977cc; 
    color: white; 
   }
  .custom-pagination .page-item .page-link { /* 비활성 버튼 스타일 */
	border-color : #1977cc;
    background-color: white; 
    color: #1977cc;    
   }
  .search-btn {
  margin-left: 10px;
  background: #1977cc;
  color: #fff;
  border: none;
  border-radius: 50px;
  padding: 8px 20px;
  white-space: nowrap;
  transition: 0.3s;
  font-size: 14px;
  display: inline-block;
  }

  .search-btn:hover {
  background: #166ab5;
  color: #fff;
  }

@media (max-width: 768px) {
  .search-btn {
    margin: 0 15px 0 0;
    padding: 6px 18px;
  }
</style>

<%@ include file="../includes/header.jsp" %>

 <!-- ======= Doctors Section ======= -->
    <section id="doctors" class="doctors with-margin">
      <div class="container">

        <div class="section-title">
          <h2>회원 진료 내역</h2>
        </div>
		<!-- 검색 타입 및 검색 키워드 -->
              <div class="row">
               <div class="col-lg-12">
                <form action="/treat/listAdm" id="searchFrm">
				<select name="type">
					<option value="H" ${pageDTOAdm.cri.type == 'H' ? 'selected' : '' }>병원</option>
					<option value="M" ${pageDTOAdm.cri.type == 'M' ? 'selected' : '' }>예약자</option>
				</select>
				<input type="text" name="keyword" value="${pageDTOAdm.cri.keyword }" size="30" placeholder="병원 또는 예약자 이름으로 검색">
				<input type="submit" class="search-btn" value="검색">	
				<input type="hidden" name="pageNum" value="${pageDTOAdm.cri.pageNum }">
				<input type="hidden" name="amount" value="${pageDTOAdm.cri.amount }">
				</form>
			   </div>
             </div>
             
        <!-- 게시물이 없는 경우 -->
		<c:if test="${empty listAdm }">
			<div class="row">
			<div class="col" align="center"> 
				<p class="alert alert-success p-5">
					진료 내역이 없습니다.
				</p></div></div>
		</c:if>     
             
        <!-- 게시물이 있는 경우 -->
		<c:if test="${!empty listAdm }">     
        <div class="row">
		<c:forEach items="${listAdm }" var="list">
		
          <div class="col-lg-6">
            <div class="member d-flex align-items-start" data-tno="${list.tno }">
              <div class="member-info">
                <h4>${list.hvo.animalhosp_name }</h4>
                <p>${list.hvo.hsop_roadname_address }</p>
                <span>${list.hvo.hsop_phonenum }</span>
                <p>${list.mvo.name }</p>
                <p>${list.trDate } ${list.trTime }</p>
              </div>
            </div>
          </div>
          
		</c:forEach>
        </div>

			<!-- paging -->
           <div class="pagination-container">
            <ul class="pagination custom-pagination">
				<%-- 이전 버튼 --%>
				<c:if test="${pageDTOAdm.prev == true }">
				<li class="page-item">
					<a href="${pageDTOAdm.start - 1 }" class="page-link">&laquo; 이전</a>
				</c:if>	
				
				<%-- 페이지 번호 버튼 --%>	
				<c:forEach begin="${pageDTOAdm.start }" end="${pageDTOAdm.end }" var="i">
				<li class="page-item ${pageDTOAdm.cri.pageNum == i ? 'active' : '' }">	<!-- pageDTO 안에 cri 넣어둠 -->
					<a href="${i }" class="page-link">${i }</a>	
				</c:forEach>	
				
				<%-- 다음 버튼 --%>	
				<c:if test="${pageDTOAdm.next == true }">	
				<li class="page-item">
					<a href="${pageDTOAdm.end + 1}" class="page-link">다음 &raquo;</a>
				</c:if>
			 </ul>	<!-- /.paging END -->
			</div>
				
			<!-- 현재 페이지 번호 및 출력 게시물 수, 검색 타입, 키워드 전송 폼 -->
			<form action="/treat/listAdm" id="actionFrm">
			<input type="hidden" name="pageNum" value="${pageDTOAdm.cri.pageNum }">
			<input type="hidden" name="amount" value="${pageDTOAdm.cri.amount }">
			<input type="hidden" name="type" value="${pageDTOAdm.cri.type }">
			<input type="hidden" name="keyword" value="${pageDTOAdm.cri.keyword }">
			</form>
	
		</c:if>
      </div>
    </section><!-- End Doctors Section -->
 
<script>
var result = "${result}";

if (result === 'successD') {
    $(document).ready(function() {
        alert("진료 정보가 삭제되었습니다.");
    });
    result = "";	// result 다시 뜨지 않게 초기화
}

 $(function() {
	// 검색 버튼 클릭 이벤트 처리
	 var searchFrm = $('#searchFrm');
	 
	 $('.search-btn').on('click', function(e) {
		 // 검색어 창이 비어있으면 alert 띄우기
		 if(searchFrm.find('input[name="keyword"]').val() == '') {
			 alert('검색어를 입력해주세요.');
			 return false;
		 }
     	// searchFrm에서 pageNum input을 찾아 pageNum 값을 1로 변경
     	searchFrm.find('input[name="pageNum"]').val('1');
     	searchFrm.submit();
    });
		 
	 // 페이징 이벤트 처리
	 var actionFrm = $('#actionFrm');
	 
	 $('.page-item a').on('click', function(event) {
        event.preventDefault(); // 기본 동작 취소 (페이지 이동 방지)
        
     	// actionFrm에서 pageNum input을 찾아 pageNum 값을 변경
     	actionFrm.find('input[name="pageNum"]').val($(this).attr('href'));
     	actionFrm.submit();
     });
	
	   //예약 카드 클릭 이벤트 처리 ------------------------------
	   //단계 : 카드 클릭 > form에 hidden태그 추가 > action의 속성 변경 > 컨트롤러 도착   => 컨트롤러에 amount에 pageNum받을 수 있도록 만들어주기
	   
	   $('.member').on('click', function(e){
	      e.preventDefault();
	      
	      //hidden태그를 생성하여 이름을 rvno로 지정하고, data-rvno 값을 rvno에 저장 
	      actionFrm.append("<input type='hidden' name='tno' value='" + $(this).data('tno') + "'>")    //actionform에 히든태그 하나 붙여줌
	       
	      //원래 form의 actionform은 "/reserv/listAdm"였는데, 이제 우리는 view로 보내야 하므로, action의 속성값을 바꿔줘야 함
	      actionFrm.attr('action', '/treat/view');
	      
	      actionFrm.submit();
	   });
	   
	   //END 게시물 제목 클릭 이벤트 처리 ------------------------------
	 
 });
</script>
 
<%@ include file="../includes/footer.jsp" %>
