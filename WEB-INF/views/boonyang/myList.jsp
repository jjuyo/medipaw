<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<style>
  body {
    margin-right: 100px;

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
             position: fixed;
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
 .card {
    margin: 10px;
    border: 1px solid #e0e0e0;
    border-radius: 5px;
  }
  .card-title {
    font-size: 18px;
    font-weight: bold;
  }
  .card-img {
   	width: 200px;
    height: 200px;
    text-align:center;
    display: block; /* 가운데 정렬을 위해 display를 block으로 변경 */
    margin: 0 auto;
  }
   .custom-row {
    display: flex;
    flex-wrap: wrap;
  }
  .custom-col {
    flex: 0 0 20%; /* 20% width to display 5 cards per row */
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
        <a href="/siljong/mine"><input type="button" value="내가 쓴 실종 신고 글" id = "pageMenu"></a><br>
        <a href="/bragging/myList"><input type="button" value="내가 쓴 자랑 글" id = "pageMenu"></a><br>
        <a href="/connecting/myList"><input type="button" value="내가 쓴 커넥팅 글" id = "pageMenu"></a><br>
        <a href="/boonyang/myList"> <input type="button" value="내가 쓴 분양 글" id = "pageMenu"></a><br>
            <!-- Add more menu items as needed -->
        </div>



		<div class="content" >
			<br><br><br><br><br><br>
   <div class="section-title">
          <h2>분양게시판</h2>
        </div>
<div class="custom-row">
    <c:forEach items="${myList}" var="list">
      <div class="custom-col">
        <div class="card">
          <img src="../resources/img/medipaw/${list.byImg}" class="card-img" alt="대표사진">
          <div class="card-body">
            <h5 class="card-title"><a class="move" href="${list.byno}">${list.title}${list.replyCnt>0 ? [list.replyCnt]: ''}</a></h5>
            <p class="card-text">구분: ${list.kind}</p>
            <p class="card-text">분양상태: ${list.state}</p>
            <p class="card-text">작성자: ${list.id}</p>
            <p class="card-text">작성일자: <fmt:formatDate value="${list.regDate}" pattern="yyyy/MM/dd" /></p>
          </div>
        </div>
      </div>
    </c:forEach>
  </div>

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
				<form action="/boonyang/myList" id="actionFrm">
					<input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum}">
					<input type="hidden" name="amount" value="${pageDTO.cri.amount}">
					<input type="hidden" name="id" value="${id}">
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
					actionFrm.append("<input type='hidden' name='byno' value='"
							+ $(this).attr('href') + "'>");

					actionFrm.attr('action', '/boonyang/view');

					actionFrm.submit();
				});
		//END 게시물 제목 클릭 이벤트 처리 -------------------

		//계정 삭제 처리 후 알림 모달창 처리 -------------------
		var result = '${result}';
		checkModal(result);

		//모달 창 재출력 방지
		history.replaceState({}, null, null); //history 초기화

		function checkModal(result) {
			//result 값이 있는 경우에 모달 창 표시
			if (result === '' || history.state) {
				return;
			}

			if (parseInt(result) > 0) { //게시물이 등록된 경우
				$('.modal-body').html(result + '계정을 삭제했습니다.');
			}

			$('#myModal').modal('show');
		}//END 게시물 처리 결과 알림 모달창 처리
	});
		
		</script>
		</body>
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>