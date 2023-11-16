<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
<head>
  <!-- 부트스트랩 CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
  <!-- 부트스트랩 JS와 jQuery, Popper.js -->
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>


</head>
<style>

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

.with-margin {
    margin-top: 150px;
}
.btn-toss2 {
  background-color: #2C4964; /* 토스의 파란색 */
  color: white; /* 글씨 색상 */
  border: none; /* 테두리 없애기 */
  padding: 10px; /* 상하 패딩 10px, 좌우 패딩 20px */
  text-align: center; /* 글씨 가운데 정렬 */
  text-decoration: none; /* 텍스트 밑줄 없애기 */
  display: inline-block; /* 인라인 블록으로 설정 */
  font-size: 16px; /* 글씨 크기 */
  cursor: pointer; /* 마우스 오버시 손가락 모양으로 변경 */
  border-radius: 4px; /* 둥근 테두리 */
  transition: background-color 0.3s; /* 배경색 변경 애니메이션 */
  width: 100px;
}

.btn-toss2:hover {
  color: #2C4964; /* 마우스가 버튼 위에 있을 때의 글씨 색상 */
}
</style>


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

<div class="container">
<br><br><br><br><br><br><br>
          <div class="section-title">
          <h2>내가 쓴 커넥팅글</h2>
        </div>
</div>
<!-- my list 테스트 -->

<!-- END 검색 타입 및 검색 키워드 -->
<!-- my list -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
            </div>	<!-- /.panel-heading -->
            <div class="panel-body">
               	<table class="table table-hover">
                    <thead>
                        <tr>
                        	<th>분류</th>
                            <th>제목</th>
                            <th>글쓴이</th>
                            <th>등록</th>
                            <th>조회</th>
                            <th>추천</th>
                        </tr>
                    </thead>
                    <tbody>
                    <!-- Model 데이터 출력 --> 
<c:forEach items="${myList }" var="cbvo">
    <tr>
   		 <td>${cbvo.classification}</td>
        <td><a class="move" href="${cbvo.cno }">${cbvo.title}</a></td>
        <td>${cbvo.id}</td>
        <td>${cbvo.displayDate}</td>
        <td>${cbvo.hit}</td>
        <td>${cbvo.recommendCnt}</td>
    </tr>
</c:forEach>

<!-- END Model 데이터 출력 -->
                    </tbody>
                </table> <!-- /.table-responsive -->

                <div class="row">
					<div class="col-lg-12">
		                <!-- 검색 타입 및 검색 키워드 -------------------->
	                	<form action="/connecting/myList" id="searchFrm">
	                		<select name="type">
	                		<c:set var="type" value="${ConnectingBraggingPageDTO.ccri.type}"/>
	                			<option value="T"   ${type == 'T' ? 'selected' : '' }>제목</option>
	                			<option value="C"   ${type == 'C' ? 'selected' : '' }>내용</option>
	                			<option value="TC"  ${type == 'TC' ? 'selected' : '' }>제목 or 내용</option>
	                		</select>
	                		<input type="text" name="keyword" value="${ConnectingBraggingPageDTO.ccri.keyword}">
	                		<button class="btn btn-default btn-sm searchBtn">
	                			검색</button>
	                		<button id="regBtn" type="button" class="btn btn-toss2" style="float: right; margin-right: 53px; font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif; font-weight: bold;">
							    글쓰기
							</button>            		
							<!-- 페이지 번호와 페이지에 표시할 게시물의 수 -->	
							<input type="hidden" name="pageNum" value="${ConnectingBraggingPageDTO.ccri.pageNum}">
		                	<input type="hidden" name="amount"  value="${ConnectingBraggingPageDTO.ccri.amount}">
	                	</form>		    
               			<!-- END 검색 타입 및 검색 키워드 -->
					</div>             
                </div>
                
                
                
                <!-- paging -------------------------------->
                <div class="pull-right">
					<ul class="pagination">
						<%-- 이전 버튼 --%>
						<c:if test="${ConnectingBraggingPageDTO.prev }">
						<li class="page-item">
							<a href="${ConnectingBraggingPageDTO.start - 1}" 
							   class="page-link">&laquo; 이전</a></c:if>
						
						<%-- 페이지 번호 버튼 --%>
						<c:forEach begin="${ConnectingBraggingPageDTO.start }" 
								   end="${ConnectingBraggingPageDTO.end }" var="i">
						<%-- <c:url var="link" value=""/> --%>
						<li class="page-item ${ConnectingBraggingPageDTO.ccri.pageNum == i ? 'active' : '' }">
							<a href="${i }" 
							   class="page-link">${i }</a>
						</c:forEach>
						
						<%-- 다음 버튼 --%>
						<c:if test="${ConnectingBraggingPageDTO.next }">
						<li class="page-item">
							<a href="${ConnectingBraggingPageDTO.end + 1}" 
							   class="page-link">다음 &raquo;</a></c:if>
					</ul>		
					
						
                </div>
                <!-- END paging -->
                
                <!-- 현재 페이지 번호 및 출력 게시물 수, 검색 타입, 키워드 전송 폼 -->
                <form action="/connecting/myList" id="actionFrm">
                	<input type="hidden" name="type" 	value="${ConnectingBraggingPageDTO.ccri.type}">
                	<input type="hidden" name="keyword" value="${ConnectingBraggingPageDTO.ccri.keyword}">
                	<input type="hidden" name="pageNum" value="${ConnectingBraggingPageDTO.ccri.pageNum}">
                	<input type="hidden" name="amount"  value="${ConnectingBraggingPageDTO.ccri.amount}">
                </form>
                
                <!-- Modal 게시물 등록 완료 시 표시 -->
                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" 
                                		data-dismiss="modal" aria-hidden="true">&times;</button>
                                <h4 class="modal-title" id="myModalLabel">
                                	MESSAGE</h4>
                            </div>
                            <div class="modal-body">
                                처리가 완료되었습니다.
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary" 
                                	    data-dismiss="modal">Close</button>
<!--                            <button type="button" class="btn btn-primary">Save changes</button> -->
                            </div>
                        </div>  <!-- /.modal-content -->
                    </div>		<!-- /.modal-dialog -->
                </div>          <!-- /.modal -->
            </div>	<!-- /.panel-body -->
        </div>  	<!-- /.panel -->
    </div>      	<!-- /.col-lg-12 -->
</div>    			<!-- /.row -->
 </div>
 </div>
<script>
//내가 쓴 게시물 버튼 클릭 이벤트 처리
// 필터링

$(function(){
	//검색 버튼 이벤트 처리 ---------------------------
	var searchFrm = $('#searchFrm')
	
	$(function(){
    //검색 버튼 이벤트 처리 ---------------------------
    var searchFrm = $('#searchFrm')

    $('.searchBtn').on('click', function(){
        //검색 시 페이지 번호를 1이 되도록 설정
        searchFrm.find("input[name='pageNum']").val('1');
        searchFrm.submit();
    });	
    //END 검색 버튼 이벤트 처리 -----------------------

    //내가 쓴 게시물 버튼 클릭 이벤트 처리
    $('#myPostsBtn').on('click', function() {
        // 세션에서 사용자 정보 가져오기
        var username = "test";

        // 검색 타입을 '작성자'로, 검색 키워드를 세션에서 가져온 사용자 이름으로 설정
        searchFrm.find("select[name='type']").val('W');
        searchFrm.find("input[name='keyword']").val(username);

        // 검색 시 페이지 번호를 1로 설정
        searchFrm.find("input[name='pageNum']").val('1');

        // 폼 제출
        searchFrm.submit();
    });
});
	
	//페이징 이벤트 처리 ------------------------------
	var actionFrm = $('#actionFrm');
	
	$('.page-item a').on('click', function(e){
		e.preventDefault();
		
		//a 태그의 href 값을 pageNum에 저장
		actionFrm.find("input[name='pageNum']")
				 .val($(this).attr('href'));
		
		actionFrm.submit();
	});
	//END 페이징 이벤트 처리 --------------------------
	
	//게시물 제목 클릭 이벤트 처리 -----------------------
	$('.move').on('click', function(e){
		e.preventDefault();
		
		//hidden 태그를 생성하여 이름을 cno로 지정하고
		//a 태그의 href 값을 cno에 저장한 후 actionFrm에 추가
		actionFrm.append("<input type='hidden' name='cno' value='" + 
								$(this).attr('href') + "'>");
		
		actionFrm.attr('action', '/connecting/view');
		
		actionFrm.submit();
	});
	//END 게시물 제목 클릭 이벤트 처리 -------------------
	
	//게시물 처리 결과 알림 모달창 처리 -------------------
	var result = '${result}';
	checkModal(result);
	
	//모달 창 재출력 방지
	history.replaceState({}, null, null); //history 초기화
	
	function checkModal(result){
		//result 값이 있는 경우에 모달 창 표시
		if(result === '' || history.state) {
			return;
		}
		
		if( parseInt(result) > 0) { //게시물이 등록된 경우
			$('.modal-body').html(result + '번 게시물이 등록되었습니다.'); 
		}
		
		$('#myModal').modal('show');
	}
	//END 게시물 처리 결과 알림 모달창 처리
	
	//게시물 등록 버튼 클릭 이벤트 처리 -------------------
	$('#regBtn').on('click', function(){
		self.location = "/connecting/register";
	});	
	//END 게시물 등록 버튼 클릭 이벤트 처리
});//END $
</script>
<%@ include file="../includes/footer.jsp" %>	
















