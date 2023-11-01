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
  .search-btn {
  margin-left: 10px;
  background: #1977cc;
  color: #fff;
  border: none;
  border-radius: 50px;
  padding: 8px 15px;
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
 <div class="menu">
        <br>
        <a href="/member/myPage"><input type="button" value="MY PAGE" id = "pageMenu"></a><br>
        <a href="/review/myList"> <input type="button" value="MY REVIEW" id = "pageMenu"></a><br>
        <a href="/mark/list"><input type="button" value="내 즐겨찾기" id = "pageMenu"></a><br>
        <input type="button" value="내 찜목록" id = "pageMenu"><br>
        <a href="/reserv/listUser"><input type="button" value="예약 내역" id = "pageMenu"></a><br>
        <a href="/treat/listUser"><input type="button" value="진료 내역" id = "pageMenu"></a><br>
        <a href="/siljong/mine"><input type="button" value="내가 쓴 실종 신고 글" id = "pageMenu"></a><br>
        <input type="button" value="자랑" id = "pageMenu"><br>
        <input type="button" value="커넥팅" id = "pageMenu"><br>
        <a href="/boonyang/myList"> <input type="button" value="내가 쓴 분양 글" id = "pageMenu"></a><br>
            <!-- Add more menu items as needed -->
        </div><!-- menu AND -->
 <!-- ======= Doctors Section ======= -->
    <section id="doctors" class="doctors with-margin">
    <div class="mcontent">
      <div class="container">
      
		<div class="content" style="margin-left: 200px;">
        <div class="section-title">
          <h2>내가 쓴 실종신고 글</h2>
        </div>
		<!-- 검색 타입 및 검색 키워드 -->
		
        <div class="row">
         <div class="col-lg-12">
          <form action="/siljong/mine" id="searchFrm">
			<select name="type">
				<option value="T" ${pageDTO.cri.type == 'T' ? 'selected' : '' }>제목</option>
				<option value="C" ${pageDTO.cri.type == 'C' ? 'selected' : '' }>내용</option>
				<option value="TC" ${pageDTO.cri.type == 'TC' ? 'selected' : '' }>제목/내용</option>
			</select>
			<input type="text" name="keyword" value="${pageDTO.cri.keyword }">
			<input type="submit" class="search-btn" value="검색">	
			<input type="hidden" name="id" value="<sec:authentication property="principal.mvo.id"/>">	<!-- 시큐리티 -->
			<input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum }">
			<input type="hidden" name="amount" value="${pageDTO.cri.amount }">
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		 </form>
		</div><!-- col-lg-12 END -->
       </div><!-- row END -->	
             
        <!-- 게시물이 없는 경우 -->
		<c:if test="${empty list }">
			<div class="row">
			<div class="col" align="center"> 
				<p class="alert alert-success p-5">
					내가 작성한 실종신고 글이 없습니다.
				</p></div></div>
		</c:if>     
             
        <!-- 게시물이 있는 경우 -->
		<c:if test="${!empty list }">     
        <table class="table table-hover">
           <thead>
               <tr>
                   <th>　글번호</th>
                   <th>제목</th>
                   <th>내용</th>
                   <th>작성자</th>
                   <th>조회수</th>
                   <th>작성일자</th>
               </tr>
           </thead>
           <tbody>
           <!-- Model 데이터 출력 -->
           <c:forEach items="${list }" var="list">
           	<tr>
           		<td>　　${list.sjno }</td>
           		<td><a class="move" href="${list.sjno }">${list.sjTitle }
           		<c:if test="${list.sjReplyCnt > 0 }">	<!-- replyCnt가 0이 아닐 때만 보이게 -->
					<span>[${list.sjReplyCnt }]</span>
				</c:if></a></td>
           		<td>${list.sjContent }</td>
           		<td>${list.id }</td>
           		<td>　${list.sjHit }</td>
           		<td><fmt:formatDate value="${list.sjRegDate}" pattern="yyyy-MM-dd"/></td>
           	</tr>
           </c:forEach>
           </tbody>
       </table>

			<!-- paging -->
           <div class="pagination-container">
            <ul class="pagination custom-pagination">
				<%-- 이전 버튼 --%>
				<c:if test="${pageDTO.prev == true }">
				<li class="page-item">
					<a href="${pageDTO.start - 1 }" class="page-link">&laquo; 이전</a>
				</c:if>	
				
				<%-- 페이지 번호 버튼 --%>	
				<c:forEach begin="${pageDTO.start }" end="${pageDTO.end }" var="i">
				<li class="page-item ${pageDTO.cri.pageNum == i ? 'active' : '' }">	<!-- pageDTO 안에 cri 넣어둠 -->
					<a href="${i }" class="page-link">${i }</a>	
				</c:forEach>	
				
				<%-- 다음 버튼 --%>	
				<c:if test="${pageDTO.next == true }">	
				<li class="page-item">
					<a href="${pageDTO.end + 1}" class="page-link">다음 &raquo;</a>
				</c:if>
			 </ul>	<!-- /.paging END -->
			</div>
				
			<!-- 현재 페이지 번호 및 출력 게시물 수, 검색 타입, 키워드 전송 폼 -->
			<form action="/siljong/mine" id="actionFrm">
			<input type="hidden" name="id" value="<sec:authentication property="principal.mvo.id"/>">	<!-- 시큐리티 -->
			<input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum }">
			<input type="hidden" name="amount" value="${pageDTO.cri.amount }">
			<input type="hidden" name="type" value="${pageDTO.cri.type }">
			<input type="hidden" name="keyword" value="${pageDTO.cri.keyword }">
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
			</form>
	
		</c:if>
		</div><!-- content END -->
      </div><!-- container END -->
	 </div><!-- mcontent END -->
    </section><!-- End Doctors Section -->

<script>
 $(function() {
	// 검색 버튼 클릭 이벤트 처리
	 var searchFrm = $('#searchFrm');
	 
	 $('.searchBtn').on('click', function(e) {
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
	
	   //게시물 제목 클릭 이벤트 처리 ------------------------------
	   //단계 : 제목 클릭 > form에 hidden태그 추가 > action의 속성 변경 > 컨트롤러 도착   => 컨트롤러에 amount에 pageNum받을 수 있도록 만들어주기
	   
	   $('.move').on('click', function(e){
	      e.preventDefault();
	      
	      //hidden태그를 생성하여 이름을 bno로 지정하고,
	      //a 태그의 href 값을 bno에 저장 
	      actionFrm.append("<input type='hidden' name='sjno' value='" + $(this).attr('href') + "'>")    //actionform에 히든태그 하나 붙여줌
	      
	      //원래 form의 actionform은 "/siljong/list"였는데, 이제 우리는 view로 보내야 하므로, action의 속성값을 바꿔줘야 함
	      actionFrm.attr('action', '/siljong/view');
	      
	      actionFrm.submit();
	   });
	   
	   //END 게시물 제목 클릭 이벤트 처리 ------------------------------
	
	 // 게시물 등록 버튼 클릭 이벤트 처리
	 $('#regBtn').on('click', function() {
		self.location = "/siljong/register";
	 });

 });
</script>
 
<%@ include file="../includes/footer.jsp" %>
