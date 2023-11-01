<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<style>
    .pagination {
        display: flex;
        justify-content: center;
    }
    body{
    margin: auto;
    }
 .searchBtn {
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

  .searchBtn:hover {
  background: #166ab5;
  color: #fff;
  }
  body {
    margin-right: 100px;
    margin-left: 100px; 
    text-align: center;
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
<div class="jumbotron" style="margin-top: 150px;">
   <div class="section-title">
          <h2>분양게시판</h2>
        </div>
	</div>
	<!-- 검색 타입 및 검색 키워드  -->
				<div class="col-lg-12" style="margin-left:50px;">

					<form action="/boonyang/list" id="searchFrm">
						<select name="type" id="searchType">
							<c:set var="type" value="${pageDTO.cri.type }"></c:set>
							<option value="T" ${type eq 'T' ? 'selected' : ''}>제목</option>
							<option value="C" ${type eq 'C' ? 'selected' : ''}>내용</option>
							<option value="K" ${type eq 'K' ? 'selected' : ''}>구분</option>
						</select> <input type="text" name="keyword" value="${pageDTO.cri.keyword }">
						<button class="btn btn-info btn-sm searchBtn">검색</button>
     
						<!-- 페이지 번호와 페이지에 표시할 게시물의 수 -->
						<input type="hidden" name="pageNum"
							value="${pageDTO.cri.pageNum }">
							 <input type="hidden"
							name="amount" value="${pageDTO.cri.amount}">
					</form>
				</div>
<div class="col-lg-12">
    <div style="text-align: right;">
    
        <a href="/boonyang/write" class="btn btn-primary btn-sm">글 작성하기</a>
    </div>
</div>

  <div class="custom-row">
    <c:forEach items="${list}" var="list">
      <div class="custom-col">
        <div class="card">
          <img src="../resources/img/medipaw/${list.byImg}" class="card-img" alt="대표사진">
          <div class="card-body">
            <h5 class="card-title"><a class="move" href="${list.byno}">${list.title}</a></h5>
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
					<ul class="pagination">
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
				<form action="/boonyang/list" id="actionFrm">
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
							<button type="button" class="btn btn-default close" data-dismiss="modal">닫기</button>
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

			if (result !== null) { //
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