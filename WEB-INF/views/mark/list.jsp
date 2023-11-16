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
   	.rem-btn {
    background: #FF8383;
    color: #fff;
    border: none;
    border-radius: 50px;
    padding: 5px 13px;
    white-space: nowrap;
    transition: 0.3s;
    font-size: 13px;
    display: inline-block;
    margin-top: 10px;
    margin-left: 5px;
  }
  .rem-btn:hover {
    background: #FF7171;
  }
   .range-btn {
    background: #1977cc;
    color: #fff;
    border: none;
    border-radius: 50px;
    padding: 5px 15px;
    white-space: nowrap;
    transition: 0.3s;
    font-size: 14px;
    display: inline-block;
    margin-top: 10px;
    margin-left: 7px;
  }
  .range-btn:hover {
    background: #166ab5;
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
          <h2>즐겨찾기 내역</h2>
        </div>
		<!-- 검색 타입 및 검색 키워드 -->
          <div class="row">
           <div class="col-lg-12">
           <div style="float: right;">
            <form action="/mark/list" id="searchFrm">
			<select name="type">	<!-- 정렬 폼 -->
			<option value="M" ${pageDTO.cri.type == 'M' ? 'selected' : '' }>등록 최신순</option>
			<option value="H" ${pageDTO.cri.type == 'H' ? 'selected' : '' }>병원 가나다순</option>
			</select>
			<input type="submit" class="range-btn" value="정렬">	
			<input type="hidden" name="id" value="<sec:authentication property="principal.mvo.id"/>">	<!-- 시큐리티 -->
			<input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum }">
			<input type="hidden" name="amount" value="${pageDTO.cri.amount }">
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
			</form>
			</div>
		  </div>
         </div>
             
        <!-- 게시물이 없는 경우 -->
		<c:if test="${empty list }">
			<div class="row">
			<div class="col" align="center"> 
				<p class="alert alert-success p-5">
					즐겨찾기 내역이 없습니다.
				</p></div></div>
		</c:if>     
             
        <!-- 게시물이 있는 경우 -->
		<c:if test="${!empty list }">     
        <div class="row">
		<c:forEach items="${list }" var="list">
		
          <div class="col-lg-6">
            <div class="member d-flex align-items-start">
            <c:if test="${empty list.hvo.animalhosp_pic }">
            <div class="pic"><img src="/resources/img/doctors/doctors-1.jpg" class="img-fluid" alt=""></div></c:if>
            <c:if test="${!empty list.hvo.animalhosp_pic }">
            <div class="pic"><img src="${list.hvo.animalhosp_pic }" class="img-fluid" alt=""></div></c:if>
              <div class="member-info">
              	<br>
                <h4><a href="/animalhosp/animalhospView?animalhosp_no=${list.hvo.animalhosp_no }" style="text-decoration: none;">${list.hvo.animalhosp_name }</a></h4>
                <p>${list.hvo.hsop_roadname_address }</p>
                <p>${list.hvo.hsop_phonenum }</p>
                <c:set var="average" value="${list.hvo.rv_cnt != 0 ? list.hvo.star_total / list.hvo.rv_cnt : 0.0}" />
                <p>⭐${average}</p>
                
                <form action="/mark/remove" id="remForm" method="post">
					<input type="hidden" name="mno" 	value="${list.mno }">
					<input type="hidden" name="animalhosp_no" id="animalhosp_no" value="${list.hvo.animalhosp_no }">
					<input type="hidden" name="id" id="id" value="<sec:authentication property="principal.mvo.id"/>">	<!-- 시큐리티 -->
					<input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum }">
					<input type="hidden" name="amount" value="${pageDTO.cri.amount }">
					<input type="hidden" name="type" value="${pageDTO.cri.type }">
					<input type="hidden" name="keyword" value="${pageDTO.cri.keyword }">
	                <!-- <button data-oper="remove" class="rem-btn" onclick="confirmDelete(event)">삭제</button> -->
	                <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
                </form>
              </div>
            </div>
          </div>
          
		</c:forEach>
        </div>

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
			<form action="/mark/list" id="actionFrm">
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
// var animalhosp_no = $("#animalhosp_no").val();
// var userId = $("#id").val();
// var header = "${_csrf.headerName}";
// var token = "${_csrf.token}";


// function confirmDelete(event) {
//     event.preventDefault(); // 기본 동작 중지

//     // 확인 창 표시
//     swal({
//            title: "즐겨찾기에서 삭제하시겠습니까?",
//            text: "",
//            icon: "warning",
//            buttons: ["취소", "확인"],
//        }).then((willSubmit) => {
//            if (willSubmit) {
//         	   $.ajax({
//                    url: "/mark/remove", 
//                    type: "POST",
//                    beforeSend: function(xhr) {
//                        xhr.setRequestHeader(header, token);
//                    },
//                    data: JSON.stringify({
//                        id: userId,
//                        animalhosp_no: animalhosp_no
//                    }),
//                    contentType: "application/json; charset=utf-8",
//                    success: function(response) {
//                        console.log(response);
//                        // 성공한 경우에만 .active 클래스를 제거하고 빈 하트로 바꿈
//                        // $('#reserv-favorite').removeClass('active');
//                    },
//                    error: function(xhr, status, error) {
//                        console.error(error);
//                    }
//                });
//            }
//         });
    
// //     if (confirm('즐겨찾기에서 삭제하시겠습니까?')) {
// //     	$('#remForm').submit(); 						// 폼 전송
// //     	console.log("삭제 알림");
// //   	}
// }

// var result = "${result}";

// if (result === 'successD') {
//     $(document).ready(function() {
//     	swal("즐겨찾기에서 삭제되었습니다.", {
//             icon: "success",
//         });
//     });
//     result = "";	// result 다시 뜨지 않게 초기화
// } else if(result === 'successR') {
// 	$(document).ready(function() {
// 		swal("즐겨찾기에 등록되었습니다.", {
//             icon: "success",
//         });
// 	});
// 	result = "";	// result 다시 뜨지 않게 초기화
// }

 $(function() {
	 // 페이징 이벤트 처리
	 var actionFrm = $('#actionFrm');
	 
	 $('.page-item a').on('click', function(event) {
        event.preventDefault(); // 기본 동작 취소 (페이지 이동 방지)
        
     	// actionFrm에서 pageNum input을 찾아 pageNum 값을 변경
     	actionFrm.find('input[name="pageNum"]').val($(this).attr('href'));
     	actionFrm.submit();
     });
	
 });
</script>
 
<%@ include file="../includes/footer.jsp" %>