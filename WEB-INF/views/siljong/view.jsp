<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp" %>
<style>
   .uploadResult {    width:100%; }
   .uploadResult ul {    display: flex;    flex-flow: row; justify-content: center; align-items:cen; }
   .uploadResult ul li { list-style: none; padding: 10px; text-align: center; }
   .uploadResult ul li img { width:100px; }
   .originImgDiv { position: fixed; top: 0; left: 0; right: 0; bottom: 0; display: none; justify-content: center; align-items:center; }
   .originImg {
   position: relative;
   display: block; 
   text-align: center; 
   margin-top: 300px;
   }
   .originImg img { width:500px; }
  .with-margin {
    margin-top: 100px;
  }
  .center-div {
    margin: 0 auto;
    float: none;
  }
  .text-center {
    text-align: center;
  }
  .btn {
    background: #CFCFCF;
    color: #fff;
    border: none;
    border-radius: 50px;
    padding: 8px 25px;
    white-space: nowrap;
    transition: 0.3s;
    font-size: 14px;
    display: inline-block;
    margin-top: 10px;
    margin-bottom: 10px;
    margin-left: 25px;
  }
  .btn:hover {
    background: #BDBDBD;
    color: #fff;
  }
  .upd-btn {
    background: #FFDD73;
  }
  .upd-btn:hover {
    background: #F2CB61;
  }
  .rem-btn {
    background: #FF8383;
  }
  .rem-btn:hover {
    background: #FF7171;
  }
  .back-btn {
    background: #CFCFCF;
  }
  .back-btn:hover {
    background: #BDBDBD;
  }
  .new-btn {
    background: #86E57F;
    padding: 8px 15px;
  }
  .new-btn:hover {
    background: #74D36D;
  }
  .left.clearfix .header {
      display: flex;
      justify-content: space-between;
      align-items: center;
  }
  .left.clearfix .header .primary-font {
      flex-grow: 1;
      margin-right: 10px;
  }
  .left.clearfix .header .text-muted {
      flex-shrink: 0;
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

<section id="doctors" class="doctors with-margin">
     <div class="container">

       <div class="section-title">
         <h2>실종신고 글</h2>
       </div>
       <div class="row">
	
         <div class="col-lg-6 center-div">
           <div class="member align-items-start">
             <div class="member-info" >
               <h4>제목&nbsp;&nbsp; ${view.sjTitle }</h4>
               <p>작성자&nbsp;&nbsp;　${view.id }</p>
             	<p>작성일자&nbsp; <fmt:formatDate value="${view.sjRegDate}" pattern="yyyy-MM-dd"/></p>
             	<p>조회수&nbsp;&nbsp;&nbsp;&nbsp; ${view.sjHit }</p>
             	<p>실종 상태 [${view.sjState }]</p>
             	<p>${view.sjContent }</p>
             	<div class="uploadResult">
				<ul></ul>
			</div>
			<div class="originImgDiv">
				<div class="originImg"></div>
			</div>
            </div>
           </div>
         </div>
         
       </div><!-- ./row -->

	<form action="/siljong/modify" id="modForm">
		<input type="hidden" name="sjno" 	value="${view.sjno }">	
		<input type="hidden" name="pageNum" value="${cri.pageNum }">
		<input type="hidden" name="amount" 	value="${cri.amount }">
		<input type="hidden" name="type" 	value="${cri.type }">
		<input type="hidden" name="keyword" value="${cri.keyword }">
		
		<div class="text-center">
		<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal" var="p"/>
			<c:if test="${p.username eq view.id || p.username eq 'admin11'}">
				<button data-oper="modify" class="btn upd-btn">수정하기</button>
				<button data-oper="remove" class="btn rem-btn" onclick="confirmDelete(event)">삭제하기</button>
			</c:if>
		</sec:authorize>
		<button data-oper="list" class="btn back-btn" formaction="/siljong/list">목록가기</button>
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		</div>
	</form>

	<!-- 댓글 목록 -->
	 <div class="row">
         <div class="col-lg-6 center-div">
           <div class="member align-items-start">
             <div class="member-info d-flex justify-content-between align-items-center">
			    <div id="commentCount">
			    	<i class="fa fa-comments fa-fw"></i>댓글(<span id="commentCount">${view.sjReplyCnt}</span>)
				</div>
			    <div>
			        <sec:authorize access="isAuthenticated()">
			        <button class="btn new-btn" id="newBtn">댓글 달기</button>
			        </sec:authorize>
			    </div>
			</div><!-- /.member-info -->
	             <div class="panel-body">
					<ul class="chat" style="list-style: none;"></ul>
					<!-- /.chat -->
					
					<!-- 댓글 Modal -->
					 <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					     <div class="modal-dialog">
					         <div class="modal-content">
					             <div class="modal-header">
					                 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					                 <h4 class="modal-title" id="replyModalLabel">REPLY</h4>
					             </div>
					             <div class="modal-body">
					             	<div class="form-group">
					             	 <label>댓글</label>
					                 <input type="text" name="sjReply" id="sjReply" class="form-control"></div>
					                <div class="form-group">
					                 <label>작성자</label>
					                 <input type="text" name="id" id="id" class="form-control" readonly></div>
					                <div class="form-group">
					                 <label>작성일자</label>
					                 <input type="text" name="sjrRegDate" id="sjrRegDate" class="form-control" readonly></div>
					             </div>
					             <div class="modal-footer">
					             	<button type="button" class="btn rem-btn"  	id="remBtn">댓글 삭제</button>
					             	<button type="button" class="btn upd-btn" 	id="modBtn">댓글 수정</button>
					             	<button type="button" class="btn new-btn" 	id="addBtn">댓글 작성</button>
					                <button type="button" class="btn back-btn" 	id="closeBtn" data-dismiss="modal">닫기</button>
					             </div>
					         </div>
					         <!-- /.modal-content -->
					     </div>
					     <!-- /.modal-dialog -->
					 </div>
					 <!-- /.댓글 modal -->
					
	             </div>
	             <!-- /.panel-body -->
	             
	             <div class="pagination-container" >
	             	<!-- 댓글 목록 페이징 -->
	             	<ul class="pagination custom-pagination"></ul>
	             </div>
	             <!-- /.pagination-container -->
	         </div>
	         <!-- /.member -->
	     </div>
	     <!-- /.col-lg-6 -->
	 </div>


     </div>
   </section><!-- End Doctors Section -->


 
 
 
<script src="/resources/js/sjReply.js"></script>
<script>
var result = "${result}";
var sjnoVal = '${view.sjno }';

if (result === 'successM') {
    $(document).ready(function() {
        swal("글이 수정되었습니다.", {
            icon: "success",
        });
    });
    result = "";	// result 다시 뜨지 않게 초기화
}

function confirmDelete(event) {
	event.preventDefault(); // 기본 동작 중지
	
	swal({
        title: "글을 삭제하시겠습니까?",
        text: "",
        icon: "warning",
        buttons: ["취소", "확인"],
    }).then((willSubmit) => {
        if (willSubmit) {
        	$('#modForm').attr('action', '/siljong/remove'); // form의 action 변경
    		$('#modForm').attr('method', 'post'); 			 // form의 method 변경
    		$('#modForm').submit(); 						 // 폼 전송
        }
    });
	
	// 확인 창 표시
// 	if (confirm('글을 삭제하시겠습니까?')) {
// 		$('#modForm').attr('action', '/siljong/remove'); // form의 action 변경
// 		$('#modForm').attr('method', 'post'); 			 // form의 method 변경
// 		$('#modForm').submit(); 						 // 폼 전송
// 	}
}

function updateCommentCount(sjnoVal) {	// 댓글 수를 요청
    $.ajax({
        type: "GET",
        url: "/sjreply/count/" + sjnoVal, // 실제 요청 URL로 변경해야 합니다.
        data: {
            sjno: sjnoVal // 실종 게시물 번호에 맞게 변경합니다.
        },
        success: function (data) {
            // 서버에서 받은 댓글 수를 특정 요소에 업데이트합니다.
            $("#commentCount").text("댓글(" + data + ")");
        },
        error: function () {
            console.error("댓글 수를 불러오는 중 오류가 발생했습니다.");
        }
    });
}

//페이지 로드 시 초기 댓글 수 표시
updateCommentCount(sjnoVal);

	var replyUL = $('.chat');		// ul 태그 찾음
	makeList(1);					// pageNum을 1로 하는 함수 호출!
	
	// 댓글 목록 출력 ----------------------------------
	function makeList(pageNum) {
	    replyService.list(
	        { sjno: sjnoVal, pageNum: pageNum },
	        function(replyCnt, result) {
	        	// 댓글을 추가한 경우 마지막 페이지를 계산해서 댓글 목록 표시
	        	if(pageNum == -1) {
	        		makeList(Math.ceil(replyCnt/10.0));			// amount 대신 3.0
	        		return;
	        	}
	        	
	        	if(result == null || result.length == 0) {		// 댓글이 없는 경우에 ul 비우기
	        		replyUL.html('');
	        		return;
	        	}
	        	
	            var liTag = '';  // 변수 초기화
	            for (var i = 0; i < result.length; i++) {
	            	liTag += '<hr><li class="left clearfix" data-sjrno=' + result[i].sjrno + '>' +
	                    '<div>' +
	                    '<div class="header">' +
	                    '<strong class="primary-font">' + result[i].id + '</strong>' + 
	                    '<small class="pull-right text-muted">' + replyService.display(result[i].sjrRegDate) + '</small>' +
	                    '</div>' +
	                    '<p>' + result[i].sjReply + '</p>' +
	                    '</div> </li>';
	            }
	            
	            replyUL.html(liTag);  			// HTML 내용 적용
	            makePageNum(replyCnt, pageNum);	// 페이지 번호 출력 함수 호출
	        }
	    );
	}
	
	// 댓글 목록 페이지 번호 출력 -------------------------------------------
	var pageNum = 1;
	var pageUL 	= $('.pagination');
	function makePageNum(replyCnt, pageNum) {
		var NUM_PER_PAGE = 5.0;										// 한 페이지에 표시할 페이지 번호 수
		var amount = 10.0;											// 한 페이지에 표시할 댓글 수
		var pages = Math.ceil(replyCnt / amount); 					// 전체 페이지 번호 수
		var end   = Math.ceil(pageNum / NUM_PER_PAGE) * NUM_PER_PAGE;	// 끝 페이지 번호
		var start = end - (NUM_PER_PAGE - 1);						// 시작 페이지 번호
			end   = end >= pages? pages : end;
		var prev  = start > 1;										// 이전 값이 있는지 여부
		var next  = end < pages;									// 다음 값이 있는지 여부
		
    	if(replyCnt == 0) {											// 댓글이 없는 경우에 ul 비우기
    		pageUL.html('');
    		return;
    	}
    	
        var pageTag = '';  // 변수 초기화
        if(prev == true) {
        	pageTag = '<li class="page-item">' + 
						'<a href="' + (start - 1) + '" class="page-link">&laquo; Previous</a>' +
                		'</li>';
        }
        for(i = start; i <= end; i++) {
        	var activeClass = (pageNum == i) ? 'active' : '';
            pageTag += '<li class="page-item ' + activeClass + '">' +
                		'<a href="' + i + '" class="page-link">' + i + '</a>' +
                		'</li>';
        }
        if(next == true) {
        	pageTag += '<li class="page-item">' + 
						'<a href="' + (end + 1) + '" class="page-link">Next &raquo;</a>' +
                		'</li>';
        }
        pageUL.html(pageTag);  // HTML 내용 적용
	}
	
	 // 페이징 이벤트 처리 -------------------------------------------
	 pageUL.on('click', 'li a', function(event) {		// pageUL에 있는 li의 a태그를 찾아서 누르면
       	event.preventDefault(); 						// 기본 동작 취소 (페이지 이동 방지)
    	pageNum = $(this).attr('href');					// href 속성에 있는 숫자로 pageNum 값을 변경
    	makeList(pageNum);
    });
	
	// 댓글 모달 --------------------------------------------------------
	
	var modal 		= $('.modal');
	var replyTxt 	= $('#sjReply');
	var replyerTxt 	= $('#id');
	var regDateTxt 	= $('#sjrRegDate');
	var addBtn 		= $('#addBtn');
	var modBtn 		= $('#modBtn');
	var remBtn 		= $('#remBtn');
	var csrfHeaderName = "${_csrf.headerName}";			// csrf 토큰 관련 변수
	var csrfTokenValue = "${_csrf.token}";
	
 	var id		= '';	
	<sec:authorize access="isAuthenticated()">
		id	= '<sec:authentication property="principal.username"/>';
	</sec:authorize>
	
	// new reply 버튼 누르면 모달 창 표시
	$('#newBtn').on('click', function() {
		modal.find('input').val('');					// input에 입력되어있는 값들을 모두 지우기! 안 그러면 전에 작성한 값들이 남음
		$('#id').val(id); 								// 작성자 표시
		regDateTxt.closest('div').hide();				// regDateTxt 근처에 있는 div를 숨김
		modal.find("button[id != 'closeBtn']").hide();	// close 버튼 빼고 다 숨김
		addBtn.show();									// 등록 버튼을 눌렀으니 add만 보이게 함
		modal.modal('show');
	});
	
	// ajax beforeSend 대신 CSRF 토큰 헤더 추가-----------------
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});
	
	// add 버튼 누르면 댓글 작성
	addBtn.on('click', function() {
	  	replyService.add(								// reply.js에 있는 add 함수 실행
			{ sjno : sjnoVal, sjReply : replyTxt.val(), id : replyerTxt.val() },
			function(result) {
				swal('댓글이 등록되었습니다.', {
		            icon: "success",
		        });
				modal.modal('hide');
				makeList(-1);							// 댓글 페이징의 마지막 페이지로 보냄
				updateCommentCount(sjnoVal);			// 댓글 수 업데이트
			}
		);
	});
	
	// 댓글 누르면 상세조회 모달 창 표시
	replyUL.on('click', 'li', function() {				// ul안의 li가 클릭 되었을 경우
		var sjrno = $(this).data("sjrno");				// 클릭한 댓글의 sjrno 저장 -> li에서 data-sjrno로 뒀음
	 	replyService.view(								// reply.js에 있는 view 함수 실행
	 		sjrno ,										// sjrno를 replyService.view로 넘겨주기
			function(result){        
	 			replyTxt.val(result.sjReply);			// 상세 조회할 값들 뿌리기
	 			replyerTxt.val(result.id);
	 			regDateTxt.val(replyService.display(result.sjrRegDate));
	 			
	 		 	regDateTxt.closest('div').show();		// 작성일자 근처에 있는 div들을 보이게 함
	 			modal.find("button[id != 'closeBtn']").hide();	// close 버튼 빼고 다 숨김
	 			
	 			if(result.id == id ){					// 본인 댓글에만
	 				modBtn.show();						// 수정 삭제 버튼 보이게 함
		 			remBtn.show();
	 			}
	 		 	modal.modal('show');
	 		 	modal.data('sjrno', sjrno);			// sjrno를 저장해서 보냄!
  			}
		);
	});
	
	// modify 버튼 누르면 댓글 수정
	modBtn.on('click', function() {
		var sjrno = modal.data('sjrno');					// modal에서 보낸 rno 받기!
	 	replyService.modify(							// reply.js에 있는 modify 함수 실행
			{ sjrno : sjrno, sjReply : replyTxt.val() },
			function(result) {
				swal('댓글이 수정되었습니다.', {
		            icon: "success",
		        });
				modal.modal('hide');
				makeList(pageNum);
			}
		)
	});
		
	// remove 버튼 누르면 댓글 삭제
	remBtn.on('click', function() {
		var sjrno = modal.data('sjrno');				// modal에서 보낸 sjrno 받기!
		
		swal({
	        title: "댓글을 삭제하시겠습니까?",
	        text: "",
	        icon: "warning",
	        buttons: ["취소", "확인"],
	    }).then((willSubmit) => {
	        if (willSubmit) {
	        	replyService.remove(							// reply.js에 있는 remove 함수 실행
        			sjrno ,
        			function(result) {
        				swal('댓글이 삭제되었습니다.', {
        		            icon: "success",
        		        });
        				modal.modal('hide');
        				makeList(pageNum);
        				updateCommentCount(sjnoVal);			// 댓글 수 업데이트
        			}
	        	);
	        }
	    });
		
	});
	
	// Close 버튼 누르면 모달 닫기
	$('#closeBtn').on('click', function() {
	    modal.modal('hide');
	});
	
	// 첨부파일 목록 --------------------------
		$.getJSON('/siljong/getAttachList/',		
					{ sjno : sjnoVal },
			function(result){							// 잘 받아와서 성공 시
					console.log(result);				// 첨부파일 리스트 콘솔에 찍어보기
					showUploadFile(result);
			}
		);	// ajax END	
	// 첨부파일 목록 END --------------------
	
	// 업로드한 파일 목록 출력 ----------------------------------
	var resultUL = $('.uploadResult ul');
    function showUploadFile(result) {
    	if(result == null || result.length == 0) {		// 목록이 없는 경우에 ul 비우기
    		resultUL.html('');
    		return;
    	}
    	
        var liTag = '';  // 변수 초기화
        for (var i = 0; i < result.length; i++) {
       		// 해당 썸네일 이미지 띄우기
       		var imgSrc = encodeURIComponent(result[i].upFolder + '/s_' + result[i].uuid + '_' + result[i].fileName);
       		var originImg = result[i].upFolder + "\\" + result[i].uuid + "_" + result[i].fileName;	// 원본 이미지 경로 + 파일명
       		originImg = originImg.replace(new RegExp(/\\/g), "/");	// \\ -> /로 변경
       		liTag += '<li><a href="javascript:showOriginal(\'' + originImg + '\')"><img src="/display?fileName=' + imgSrc + '"></a><br>' + result[i].fileName + '</li>';
        }
        resultUL.html(liTag);  							// HTML 내용 적용
    }
    
    // 썸네일 클릭 시 원본 이미지 표시
    function showOriginal(originImg) {
    	var originImgHref = $('.originImg');
    	var originImgDiv = $('.originImgDiv');
    	originImgDiv.css("display", "flex").show();
    	var imgTag = ''; 
    	imgTag += '<img src = "/display?fileName=' + originImg +'">';
    	
    	originImgHref.html(imgTag);
    	originImgHref.animate({width:'100%', height:'100%'}, 1000);	// <- 1초
    }
	
	// 원본 이미지를 클릭했을 때 숨김 처리하는 이벤트 추가
    $('.originImgDiv').on('click', function() {
        $('.originImg').animate({width:'0%', height:'0%'}, 1000);	// <- 1초
        $(this).hide();
    });

</script>

<%@ include file="../includes/footer.jsp" %>
