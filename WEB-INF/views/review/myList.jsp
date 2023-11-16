<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<style>
body{
margin-right:200px;
}
    .pagination {
        display: flex;
        justify-content: center;
    }
    
    .main-content {
   /* ... 기존 스타일 ... */
   height: calc(100vh - 60px); /* 예시로 헤더와 푸터 높이가 각각 30px라고 가정 */
}

.footer {
   /* ... 기존 스타일 ... */
   height: 30px; /* 예시로 푸터 높이가 30px라고 가정 */
}
             .menu {
            width: 200px;
            height: 100vh;
            background-color: 		#B0C4DE		;
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
         margin-left:200px;
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
            height: 100vh; /* 화면 전체 높이 사용 */
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

       .edit-button {
          display:inline-block;
          text-align:center;
          background-color:#B0C4DE; /* Green */
          color:white;
          text-decoration:none;
          padding :7.5px ;
	  float:right ; 
	  margin :7.5px ; 
	  border:none ; /* 테두리 제거 */
	  border-radius :7.5px ; /* 동그랗게 */
       }
       
       .edit-button:hover{
         background-color:#2F4F4F ;
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
</style>
<body>
 <div class="mcontent">

 <div class="menu">
        <br><br><br><br><br>
        <a href="/member/myPage"><input type="button" value="MY PAGE" id = "pageMenu"></a><br>
        <a href="/review/myList"> <input type="button" value="MY REVIEW" id = "pageMenu"></a><br>
        <a href="/mark/list"><input type="button" value="내 즐겨찾기" id = "pageMenu"></a><br>
        <a href="/like/mypetmap"><input type="button" value="내 찜목록" id = "pageMenu"></a><br>
        <a href="/reserv/listUser"><input type="button" value="예약 내역" id = "pageMenu"></a><br>
        <a href="/treat/listUser"><input type="button" value="진료 내역" id = "pageMenu"></a><br>
        <a href="/siljong/list"><input type="button" value="내가 쓴 실종 신고 글" id = "pageMenu"></a><br>
        <input type="button" value="자랑" id = "pageMenu"><br>
        <input type="button" value="커넥팅" id = "pageMenu"><br>
        <a href="/boonyang/myList"> <input type="button" value="내가 쓴 분양 글" id = "pageMenu"></a><br>
            <!-- Add more menu items as needed -->
        </div>



		<div class="content">
			<br><br><br><br><br><br>
 <div class="section-title">
          <h2>⭐나의 리뷰</h2>
        </div>
						<table class="table table-hover">
							<thead>
								<tr>
									<th>리뷰번호</th>
									<th>별점</th>
									<th>제목</th>
									<th>작성자</th>
									<th>작성일자</th>
								
								</tr>
							</thead>

							<tbody>
								<c:forEach items="${list }" var="list">
									<c:set var="rno" value="${list.rno }" />
									<c:set var="title" value="${list.title }" />
									<c:set var="star" value="${list.star }" />
									<c:set var="content" value="${list.content }" />
									<c:set var="id" value="${list.id }" />
									<c:set var="regDate" value="${list.regDate }" />
									<c:set var="pageNum" value="${pageNum }" />

									<tr>
										<td>${rno }</td>
										<td>⭐${star }</td>
										<td><a class="move" href="${rno}" >
												${title }</a></td>
										
										<td>${id }</td>
										<td><fmt:formatDate value="${regDate}" pattern="yyyy/MM/dd" /></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
<!-- paging -------------------------------->
				<div class="pull-right">
					<ul class="pagination justify-content-center">
						<%-- 이전 버튼 --%>
						<c:if test="${pageDTO.prev }">
							<li class="page-item"><a href="${pageDTO.start - 1}"
								class="page-link">&laquo; Previous</a>
						</c:if>

						<%-- 페이지 번호 버튼 --%>
						<c:forEach begin="${pageDTO.start }" end="${pageDTO.end }" var="i">
							<%-- <c:url var="link" value=""/> --%>
							<li
								class="page-item ${pageDTO.cri.pageNum == i ? 'active' : '' }">
								<a href="${i }" class="page-link">${i }</a>
						</c:forEach>

						<%-- 다음 버튼 --%>
						<c:if test="${pageDTO.next }">
							<li class="page-item"><a href="${pageDTO.end + 1}"
								class="page-link">Next &raquo;</a>
						</c:if>
					</ul>
				</div>
				<!-- END paging -->

				<!-- 현재 페이지 번호 및 출력 게시물 수 전송 폼 -->
				<form action="/review/list" id="actionFrm">
					<input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum}">
					<input type="hidden" name="amount" value="${pageDTO.cri.amount}">
				</form>
					<!-- Modal 게시물 등록 완료 시 표시 -->
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
					aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h4 class="modal-title" id="myModalLabel">MESSAGE</h4>
							</div>
							<div class="modal-body">처리가 완료되었습니다.</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-primary"
									data-dismiss="modal">Close</button>
								<!--                            <button type="button" class="btn btn-primary">Save changes</button> -->
							</div>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>
				<!-- /.modal -->
</div>
</div>
<script>
	$(function() {		
		//페이징 이벤트 처리 ------------------------------
		var actionFrm = $('#actionFrm');

		$('.page-item a').on('click', function(e) {
			e.preventDefault();

			//a 태그의 href 값을 pageNum에 저장
			actionFrm.find("input[name='pageNum']").val($(this).attr('href'));

			actionFrm.submit();
		});
		//END 페이징 이벤트 처리 ------------------------------
//게시물 제목 클릭 이벤트 처리 -----------------------
		$('.move').on(
				'click',
				function(e) {
					e.preventDefault();

					//hidden 태그를 생성하여 이름을 bno로 지정하고
					//a 태그의 href 값을 bno에 저장한 후 actionFrm에 추가
					actionFrm.append("<input type='hidden' name='rno' value='"
							+ $(this).attr('href') + "'>");

					actionFrm.attr('action', '/review/view');

					actionFrm.submit();
				});
		//END 게시물 제목 클릭 이벤트 처리 -------------------

	
	});
		
		</script>
		</body>
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>