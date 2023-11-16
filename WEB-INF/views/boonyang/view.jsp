<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/resources/css/note.css">
<script src="/resources/js/note.js"></script>	
<style>
 .uploadResult {    width:100%; }
   .uploadResult ul {    display: flex;    flex-flow: row; }
   .uploadResult ul li { list-style: none; padding: 10px; }
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
 .rev-btn {
    background: #1977cc;
  }
  .rev-btn:hover {
    background: #166ab5;
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

.form-control {
            width: 60%; /* Set the width to 50% of the container */
            padding: 10px;
            margin: 5px 0;
            border-radius: 4px;
             justify-content: center;
             display: flex;
        }
   
</style>
</head>

<body>
<div class="container">
   <br><br><br><br><br><br><br>
 <div class="section-title">
          <h2>분양 글 </h2>
        </div>

     <div class="img">
            <label for="byImg">대표사진</label><br>
          <img src="../resources/img/medipaw/${bvo.byImg }" style="width:250px; height:250px;" id="byImg">
<hr>
        </div>
        <div class="uploadResult">
        <p>추가 사진
				<ul></ul>
			</div>
 			<div class="originImgDiv">
				<div class="originImg"></div>
			</div> 
			<hr>
     <form id='form' method='post'>
		<div style="justify-content: center;">
		    <label for="id">작성자</label>
		    <input type="text" name="id" class="form-control" value='${bvo.id}' readonly style="background-color: lightgray;">
		    <div class="tooltip">툴팁
		        <span class="tooltiptext">Send note</span>
		    </div>
		</div>
      <div>
            <label for="title">제목</label>
            <input type="text" id="title" name="title" class="form-control" value='${bvo.title}'  style="background-color: lightgray;" readonly>
        </div>
        <div>
            <label for="kind">동물종 </label>
            <input type="text" id="kind" name="kind" class="form-control" value='${bvo.kind}'  style="background-color: lightgray;" readonly>
        </div>
        <div>
        	<label for="gender">성별: </label>　
        ${bvo.gender }
        </div>
   <div>
    <label for="age">나이: </label>　
   ${bvo.age }세
</div>

         <div>
			<label>내용</label>
			<textarea name="content" class="form-control"  style="background-color: lightgray;"
							  rows="3" readonly>${bvo.content }</textarea></div>
         <div>
            <label for="state">분양상태: </label>　
        ${bvo.state }
        </div>

        <div class="button-container" style="margin-right: 400px;">
    <div class="form-group row mt-4">
        <div class="col text-center">
            <button  data-oper="list" class="btn back-btn" style="margin-right:600px; width:90px;" formaction="/boonyang/list" formmethod="get">목록으로</button>
        </div>
         <sec:authorize access="isAuthenticated()">
      <sec:authentication property="principal" var="p"/> 
         <c:if test="${p.username eq bvo.id || p.username eq 'admin11'}">
        <div class="col text-center">
            <a class="btn upd-btn" href="/boonyang/modify?byno=${bvo.byno }">수정</a>
            <button data-oper="remove" class="btn rem-btn" onclick="delChk(event);">삭제</button>
        </div>
        </c:if>
        </sec:authorize>
    </div>
</div>

	<input type="hidden" name="pageNum" value="${cri.pageNum }">
					<input type="hidden" name="amount"  value="${cri.amount}">
					<input type="hidden" name="type" value="${cri.type }">
					<input type="hidden" name="keyword"  value="${cri.keyword}">
   <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
   <input type="hidden"  id="img"  name="img" value=""/>
    </form>
    </div>
         <hr class="my-4">
    <!-- 댓글 목록 ---------------------------------> 
<!-- 댓글(reply) 부분 -->
<div class="row" style="margin-left: 150px;">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <i class="fa fa-comments fa-fw"></i> 댓글
                <sec:authorize access="isAuthenticated()">
                   <button id="newBtn" class="btn btn-info btn-xs" style="float: right; margin-right:100px;">댓글 쓰기</button>

                </sec:authorize>
            </div>
            <div class="panel-body">
                <ul class="chat">
                    <!-- reply START -->
                    <li class="left clearfix" data-byrno='12'>
                        <div>
                            <div class="header">
                                <strong class="primary-font">user00</strong>
                                <small class="pull-right text-muted">2023-11-22 11:22</small>
                            </div>
                            <p>Good job!</p>
                        </div>
                       
                    </li>
                    <!-- reply end -->
                </ul>
            </div>
            <div class="panel-footer">
                <!-- 댓글 목록 페이징 -->
                <ul class="pagination pull-right"></ul>
            </div>
        </div>
    </div>
</div>

<!-- END 댓글 목록 ----------------------------->  

<!-- 댓글 작성 Modal --------------------------->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" 
                		data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">
                	<i class="fa fa-comments fa-fw"></i>
                	REPLY</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                	<label>댓글</label>
                	<input type="text" name="reply" id="reply" class="form-control">
                </div>
                <div class="form-group">
                	<label>작성자</label>
                	<input type="text" name="id" id="id" class="form-control" readonly>
                </div>
                <div class="form-group">
                	<label>작성일자</label>
                	<input type="text" name="regDate" id="regDate" class="form-control" readonly>
                </div>
            </div>
            <div class="modal-footer">
                <button id="remBtn" type="button" class="btn btn-danger">삭제</button>
                <button id="modBtn" type="button" class="btn btn-warning">수정</button>
                <button id="addBtn" type="button" class="btn btn-primary">작성</button>
                <button id="closeBtn close" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>  <!-- /.modal-content -->
    </div>		<!-- /.modal-dialog -->
</div>          <!-- /.modal -->
<!-- END 댓글 작성 Modal --------------------------->

<script src="/resources/js/reply.js"></script> 
  </body>    


<script>
var result = '${result}';
if (result !== null && result !== '') {
    swal(result,{icon:'success'});
}

// 변수를 사용하여 이미지 상태를 추적합니다.
var isExpanded = false;

$('.img').on('click', function () {
    if (isExpanded) {
        // 이미지가 확대된 경우, 원래 크기로 축소
        $('#byImg').animate({ width: '250px', height: '250px' }, 1000);
        isExpanded = false;
    } else {
        // 이미지가 축소된 경우, 확대
        $('#byImg').animate({ width: '70%', height: '70%' }, 1000);
        isExpanded = true;
    }
});
var bnoVal = '${bvo.byno}';

function goBack() {
    history.back();
}

function delChk(event){
	event.preventDefault();
      
      swal({
           title: "글을 삭제하시겠습니까?",
           text: "",
           icon: "warning",
           buttons: ["취소", "확인"],
       }).then((willSubmit) => {
           if (willSubmit) {
             $('#form').attr('action', '/boonyang/remove?byno=${bvo.byno }');
             $('#form').submit(); // 폼 전송
           }
       });
}
	function goBack() {
		history.back();
	}
	
	var replyUL = $('.chat');

	makeList(1);	
	
	//댓글 목록 출력 ----------------------------------
	function makeList(pageNum){
		replyService.list(
			{ byno : bnoVal, pageNum : pageNum },
			function(replyCnt, result){
				//댓글을 추가한 경우 마지막 페이지를 계산해서 목록 표시
				if(pageNum == -1){
					pageNum = Math.ceil(replyCnt / 3.0);
					makeList(pageNum);
					return;
				}
				
				//댓글이 없는 경우 ul 비우기
				if(result == null || result.length == 0) {
					replyUL.html('');
					return;
				}
				
				//댓글 목록 li 작성
				var liTag = ''; 
				for(var i=0 ; i<result.length ; i++){
					liTag += '<li class="left clearfix" data-byrno="' + result[i].byrno + '">' + 		
		    				 	'<div>' + 
									'<div class="header">' + 
										'<strong class="primary-font">' +
											result[i].id + '</strong>' +
										'<small class="pull-right text-muted">' + 
											replyService.display(result[i].regDate) + '</small></div>' +
									'<p>' + result[i].reply + '</p>' +
								'</div>' +
							  '</li>';
				}
				
				replyUL.html(liTag);//ul에 li 붙이기
				makePageNum(replyCnt, pageNum); //페이지 번호 출력 함수 호출
			}
		);
	}//END 댓글 목록 출력 -----------------------------

	//댓글 목록 페이지 번호 출력 ------------------------
	var pageNum = 1;
	var pageUL = $('.pagination');

	function makePageNum(replyCnt, pageNum){
		var NUM_PER_PAGE = 5.0;	 
		var amount = 3.0;		 
		var pages = Math.ceil(replyCnt/amount);	 
		var end = Math.ceil(pageNum/NUM_PER_PAGE) * NUM_PER_PAGE;  
		var start = end - (NUM_PER_PAGE - 1);					 
			end = end >= pages ? pages : end;
		var prev = start > 1;	 
		var next = end < pages;	 
		
		//페이징 li 작성 및 ul에 추가---------------
		var liTag = '';
		
		//이전 버튼 만들기
		if(prev) {
			liTag += '<li class="page-item">' + 
						'<a href="' + (start - 1) + '" class="page-link">&laquo; Previous</a>';
		}
		
		//페이지 번호 만들기
		for(var i=start ; i <= end ; i++){
			liTag += '<li class="page-item ' + (pageNum == i ? "active" : "") + '">' + 
						'<a href="' + i + '" class="page-link">' + i + '</a></li>'; 
		}
		
		//다음 버튼 만들기
		if(next) {
			liTag += '<li class="page-item">' + 
						'<a href="' + (end + 1) + '" class="page-link">Next &raquo;</a></li>';
		}
		
		pageUL.html(liTag);	//ul에 추가하기
	}

	//페이지 번호 클릭 이벤트 처리  --------
	pageUL.on('click', 'li a', function(e){
		e.preventDefault();
		pageNum = $(this).attr('href');
		makeList(pageNum);
	});//END 페이지 번호 클릭 이벤트 처리  ----
	//END 댓글 목록 페이지 번호 출력 --------------------



	//댓글 작성 모달 창 --------------------------------
	var modal = $('.modal');
	var replyTxt = $('#reply');
	var replyerTxt = $('#id');
	var regDateTxt = $('#regDate');

	var modBtn = $('#modBtn');
	var remBtn = $('#remBtn');
	var addBtn = $('#addBtn');

	var id = null;
	<sec:authorize access="isAuthenticated()">
	id = '<sec:authentication property="principal.username"/>'
	</sec:authorize>

	//new Reply 버튼 클릭 이벤트 처리 -----------
	$('#newBtn').on('click', function(){
		modal.find('input').val('');
		modal.find('input[name="id"]').val(id);
		regDateTxt.closest('div').hide();
		modal.find("button[id != 'closeBtn']").hide();
		addBtn.show();
		
		modal.modal('show');
	});//END new Reply 버튼 클릭 이벤트 처리 ----

	var csrfHeaderName = '${_csrf.headerName}';
	var csrfTokenValue = '${_csrf.token}';
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});


	//Add 버튼 클릭 이벤트 처리 -----------------
	addBtn.on('click', function(){
		replyService.add(
			{ byno : bnoVal, 
			  reply : replyTxt.val(), 
			  id : replyerTxt.val() },
			function(result){
				swal('댓글이 등록되었습니다.',{icon:'success'});
				modal.find('input').val('');
				modal.modal('hide');
//				makeList(1);	
				makeList(-1);	//
			}
		);
	});//END Add 버튼 클릭 이벤트 처리 -----------------

	//댓글 클릭 이벤트 처리 ---------------------
	replyUL.on('click', 'li', function(){
		var byrno = $(this).data('byrno');
		console.log(byrno);
		replyService.view(
				byrno,
			function(result){	
				replyTxt.val(result.reply);
				replyerTxt.val(result.id);
				regDateTxt.val(replyService.display(result.regDate));
				
				regDateTxt.closest('div').show();
				modal.find("button[id != 'closeBtn']").hide();
				if(id == replyerTxt.val() || id == 'admin11'){
				modBtn.show();
				remBtn.show();
				}
				
				modal.data('byrno', byrno);
				modal.modal('show');
			}
		);
		
	});//END 댓글 클릭 이벤트 처리 -----------------

	//Modify 버튼 클릭 이벤트 처리 -----------------
	modBtn.on('click', function(){
		replyService.modify(
			{ byrno : modal.data('byrno'), 
			  reply : replyTxt.val()    },
			function(result){
				swal('댓글이 수정되었습니다.',{icon:'success'});
				modal.modal('hide');
				makeList(pageNum);
			}
		);
	});//END Modify 버튼 클릭 이벤트 처리 ----------

	//Remove 버튼 클릭 이벤트 처리 -----------------
   remBtn.on('click', function() {
      var byrno = modal.data('byrno');            // modal에서 보낸 sjrno 받기!
      
      swal({
           title: "댓글을 삭제하시겠습니까?",
           text: "",
           icon: "warning",
           buttons: ["취소", "확인"],
       }).then((willSubmit) => {
           if (willSubmit) {
              replyService.remove(                     // reply.js에 있는 remove 함수 실행
            		  byrno ,
                 function(result) {
                    swal('댓글이 삭제되었습니다.', {
                          icon: "success",
                      });
                    modal.modal('hide');
                    makeList(pageNum);
                    updateCommentCount(bynoVal);         // 댓글 수 업데이트
                 }
              );
           }
       });
      
   });
	//END Remove 버튼 클릭 이벤트 처리 -------------
	//END 댓글 작성 모달 창 ----------------------------
	$(".close").on("click", function(){
		$('#myModal').modal('hide');
	});
	var bynoVal = '${bvo.byno }';
	// 첨부파일 목록 --------------------------
	$.getJSON('/boonyang/getAttachList/',		
				{ byno : bynoVal },
		function(result){							// 잘 받아와서 성공 시
				console.log(result);// 첨부파일 리스트 콘솔에 찍어보기
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
       		liTag += '<li><a href="javascript:showOriginal(\'' + originImg + '\')"><img src="/display?fileName=' + imgSrc + '"><br></li>';
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


<%@ include file="/WEB-INF/views/includes/footer.jsp" %>