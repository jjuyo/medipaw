<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<style>
    .pagination {
        display: flex;
        justify-content: center;
    }
  body {
    margin-right: 100px;
    margin-left: 100px; 
}
</style>
<body>
<div class="jumbotron" style="margin-top: 150px;">
		        <div class="section-title">
          <h2>병원관계자 목록</h2>
        </div>
	</div>

			 <div class="col-lg-12">
        <form action="/admin/staffList" id="searchFrm">
            <div>
                <select name="type" id="searchType">
                    <c:set var="type" value="${pageDTO.cri.type }"></c:set>
                    <option value="N" ${type eq 'N' ? 'selected' : ''}>대표자명</option>
                    <option value="I" ${type eq 'I' ? 'selected' : ''}>아이디</option>
                </select>
                <input type="text" name="keyword" value="${pageDTO.cri.keyword }">
                <button class="btn btn-default btn-sm searchBtn">검색</button>
            </div>
  
	
            <input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum }"/>
            <input type="hidden" name="amount" value="${pageDTO.cri.amount}"/>
        </form>
    </div>

						<table class="table table-hover">
							<thead>
								<tr>
									<th>대표자명</th>
									<th>아이디</th>
									<th>전화번호</th>
									<th>이메일</th>
									<th>사업자번호</th>
									<th>가입일자</th>
								
								</tr>
							</thead>

							<tbody>
								<c:forEach items="${list }" var="list">
									<c:set var="sname" value="${list.sname }" />
									<c:set var="sid" value="${list.sid }" />
									<c:set var="sphone" value="${list.sphone }" />
									<c:set var="semail" value="${list.semail }" />
									<c:set var="companyNum" value="${list.companyNum }" />
									<c:set var="regDate" value="${list.regDate }" />
									<c:set var="pageNum" value="${pageNum }" />
									<c:set var="type" value="${type }" />
									<c:set var="keyword" value="${keyword }" />
									<tr>
										<td>${sname }</td>
										<td><a class="move" href="${sid}" >
												${sid }</a></td>
										<td>${sphone }</td>
										<td>${semail }</td>
										<td>${companyNum }</td>
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
				<form action="/admin/staffList" id="actionFrm">
					<input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum}">
					<input type="hidden" name="amount" value="${pageDTO.cri.amount}">
					<input type="hidden" name="type" value="${pageDTO.cri.type}">
					<input type="hidden" name="keyword" value="${pageDTO.cri.keyword}">
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

<script>
	$(function() {
		var searchFrm = $('#searchFrm');
		$('.searchBtn').on('click', function() {
			//검색 키워드 입력하지 않은 경우
			if (searchFrm.find("input[name='keyword']").val() == '') {
				alert('검색 키워드를 입력해 주세요.');
				return false;
			}
			//1페이지가 아닌 페이지에서 검색 시 페이지넘 1로 지정
			searchFrm.find("input[name='pageNum']").val('1');
			searchFrm.submit();
		});

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
					actionFrm.append("<input type='hidden' name='sid' value='"
							+ $(this).attr('href') + "'>");

					actionFrm.attr('action', '/admin/view');

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