<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<style>
  body {
    margin-right: 300px;
    margin-left: 300px; 
}
</style>
<body>
<div class="jumbotron" style="margin-top: 150px;">
	   <div class="section-title">
          <h2>⭐리뷰</h2>
        </div>
		<hr>
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
									<c:set var="star" value="${list.star }" />
									<c:set var="title" value="${list.title }" />
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
				<input type="hidden" name="animalhosp_no" value="${param.animalhosp_no}">
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
								<button type="button" class="btn btn-primary close"
									data-dismiss="modal">Close</button>
								<!--                            <button type="button" class="btn btn-primary">Save changes</button> -->
							</div>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>
				<!-- /.modal -->

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

			if (parseInt(result) !== null) { //게시물이 등록된 경우
				$('.modal-body').html(result);
			}

			$('#myModal').modal('show');
		}//END 게시물 처리 결과 알림 모달창 처리
	});
	$(".close").on("click", function(){
		$('#myModal').modal('hide');
	});
	
	
		</script>
		</body>
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>