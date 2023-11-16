<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
  .menu {
     position: fixed;
    width: 200px;
    height: 100vh;
   background-color: #B0C4DE;
    padding-top: 20px;
	}
    .menu a {
    display: block;
    text-decoration: none;
    color:black; 
    transition-duration :1s ;
    padding-left :10px ;
       }
	.menu a:hover{
	    transform :scale(1.1) ;
	}
       .content {
       margin-left:300px;
           flex-grow: 1;
           padding: 20px;
           color: black;
           transition-duration: 1s;
       }
     
       .mcontent {
           display: flex;
           width: 100%; /* 전체 너비 사용 */
       }
       .mcontent .menu,
       .mcontent .content {
           height: 100%; /* 화면 전체 높이 사용 */
       }
       .footer {
           background-color: #333;
           color: white;
           text-align: center;
           padding: 10px;
       }
       .content h1 {
           border-bottom: 1px solid #D3D3D3; /* 연한 회색 선 */
           padding-bottom: 10px;
       }

       .info-block {
           background-color: #f9f9f9;
           border-radius: 5px;
           margin-bottom: 10px;
           padding: 10px; 
       }

       .info-item {
          border-radius: 5px;
          background-color:#E6E6FA ;
          margin-bottom :5px ;
          padding :10px ;
       }

#pageMenu{
   display:block ;
   text-align:center ; 
   background-color:#B0C4DE ;  
   color:black ;  
   text-decoration:none ;  
   width :80% ;
   border:none ; /* 테두리 제거 */
}

#pageMenu:hover{
    transform :scale(1.1) ;
    transition-duration:0.25s ;
}

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
</style>

<%@ include file="../includes/header.jsp" %>

 <div class="menu">
        <br>
        <a href="/member/myPage"><input type="button" value="MY PAGE" id = "pageMenu"></a><br>
        <a href="/review/myList"> <input type="button" value="MY REVIEW" id = "pageMenu"></a><br>
        <a href="/mark/list"><input type="button" value="내 즐겨찾기" id = "pageMenu"></a><br>
        <a href="/like/mypetmap"><input type="button" value="내 찜목록" id = "pageMenu"></a><br>
        <a href="/reserv/listUser"><input type="button" value="예약 내역" id = "pageMenu"></a><br>
        <a href="/treat/listUser"><input type="button" value="진료 내역" id = "pageMenu"></a><br>
        <a href="/siljong/mine"><input type="button" value="내가 쓴 실종 신고 글" id = "pageMenu"></a><br>
        <a href="/bragging/myList"><input type="button" value="내가 쓴 자랑 글" id = "pageMenu"></a><br>
        <a href="/connecting/myList"><input type="button" value="내가 쓴 커넥팅 글" id = "pageMenu"></a><br>
        <a href="/boonyang/myList"> <input type="button" value="내가 쓴 분양 글" id = "pageMenu"></a><br>
            <!-- Add more menu items as needed -->
        </div><!-- menu AND -->

 <!-- ======= Doctors Section ======= -->
    <section id="doctors" class="doctors with-margin">
    <div class="mcontent">
      <div class="container">

		<div class="content" style="margin-left: 200px;"> 
        <div class="section-title">
          <h2>내 진료 내역</h2>
        </div>
             
        <!-- 게시물이 없는 경우 -->
		<c:if test="${empty listUser }">
			<div class="row">
			<div class="col" align="center"> 
				<p class="alert alert-success p-5">
					진료 내역이 없습니다.
				</p></div></div>
		</c:if>     
             
        <!-- 게시물이 있는 경우 -->
		<c:if test="${!empty listUser }">     
        <div class="row">
		<c:forEach items="${listUser }" var="list">
		
          <div class="col-lg-6">
            <div class="member d-flex align-items-start" data-tno="${list.tno }">
              <div class="member-info">
                <h4>${list.hvo.animalhosp_name }</h4>
                <p>${list.hvo.hsop_roadname_address }</p>
                <span>${list.hvo.hsop_phonenum }</span>
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
				<c:if test="${pageDTOUser.prev == true }">
				<li class="page-item">
					<a href="${pageDTOUser.start - 1 }" class="page-link">&laquo; 이전</a>
				</c:if>	
				
				<%-- 페이지 번호 버튼 --%>	
				<c:forEach begin="${pageDTOUser.start }" end="${pageDTOUser.end }" var="i">
				<li class="page-item ${pageDTOUser.cri.pageNum == i ? 'active' : '' }">	<!-- pageDTO 안에 cri 넣어둠 -->
					<a href="${i }" class="page-link">${i }</a>	
				</c:forEach>	
				
				<%-- 다음 버튼 --%>	
				<c:if test="${pageDTOUser.next == true }">	
				<li class="page-item">
					<a href="${pageDTOUser.end + 1}" class="page-link">다음 &raquo;</a>
				</c:if>
			 </ul>	<!-- /.paging END -->
			</div>
				
			<!-- 현재 페이지 번호 및 출력 게시물 수, 검색 타입, 키워드 전송 폼 -->
			<form action="/treat/listUser" id="actionFrm">
			<input type="hidden" name="id" value="<sec:authentication property="principal.mvo.id"/>">
			<input type="hidden" name="pageNum" value="${pageDTOUser.cri.pageNum }">
			<input type="hidden" name="amount" value="${pageDTOUser.cri.amount }">
			<input type="hidden" name="type" value="${pageDTOUser.cri.type }">
			<input type="hidden" name="keyword" value="${pageDTOUser.cri.keyword }">
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
			</form>
	
		</c:if>
		</div><!-- content END -->
      </div><!-- container END -->
      </div><!-- mcontent END -->
    </section><!-- End Doctors Section -->
 
<script>
var result = "${result}";

if (result === 'successDC') {
    $(document).ready(function() {
    	swal("진료 정보가 삭제되었습니다.", {
            icon: "success",
        });
    });
    result = "";	// result 다시 뜨지 않게 초기화
}

 $(function() {
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
	       
	      //원래 form의 actionform은 "/treat/listUser"였는데, 이제 우리는 view로 보내야 하므로, action의 속성값을 바꿔줘야 함
	      actionFrm.attr('action', '/treat/view');
	      
	      actionFrm.submit();
	   });
	   
	   //END 게시물 제목 클릭 이벤트 처리 ------------------------------
	 
 });
</script>
 
<%@ include file="../includes/footer.jsp" %>
