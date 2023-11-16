<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Place Detail Page</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src= "https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
	
    <style>
    	.review-info.place-container {
    		display: flex;
    		justify-content: space-between;
    		align-items: center;
		}
	
        /* 스타일링을 위한 CSS 코드 */
		 .review-rating {
		    display: flex;
		}
		
		.review-rating p {
		    margin-right: 10px;
		}
        .other-info.place-container {
		    text-align: left;
		    align-items: flex-start;
		}
        body {
            background-color: #eee;
            margin: 0;
            padding: 20px;
        }
        .place-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            background-color: #fff;
            padding: 20px;
            margin-bottom: 20px;
        }
        .place-image {
            width: 100%;
            height: 100%;
            min-height :200px; 
            background-color: inherit; /* 이미지 영역의 배경색 */
        }
        .review-info {
           margin-top: 20px; 
           border-top :1px solid #ccc; /* 리뷰 정보와 예약 정보 사이의 구분선 */
           padding-top :20px; 
      	}
      	.other-info {
           margin-top :20px; 
           border-top :1px solid #ccc; /* 기타 정보와 리뷰/예약 정보 사이의 구분선 */
           padding-top :20px; 
      	}      
		.favorite-button .fa-star {
		    display: none;
		}
		
		/* favorite-button에 .active 클래스가 추가될 경우 채운 하트 아이콘을 보여줍니다. */
		.favorite-button.active .fa-solid.fa-star.fa-2xl {
		    display: inline-block;
		}
		
		/* favorite-button에 .active 클래스가 없는 경우 빈 하트 아이콘을 보여줍니다. */
		.favorite-button:not(.active) .fa-regular.fa-star.fa-2xl {
		    display: inline-block;
		}
		  .upd-btn {
 		   background: #FFDD73;
 		 }
 		 .upd-btn:hover {
 	 	  background: #F2CB61;
  		}
  		
  		
  		
    </style>
</head>
<body>
<div class="place-container">
    <div class="place-image"></div>
</div>

<div class="review-info place-container">
    <h1 class="place-name" id="animalhosp-name">이름</h1>
    <sec:authorize access="hasRole('ROLE_MEMBER')">
		    <div id="reserv-favorite" class="favorite-button" style="margin-bottom: 7px;">
		    	<i class="fa-regular fa-star fa-2xl" style="color: yellow;"></i>
		    	<i class="fa-solid fa-star fa-2xl" style="color: yellow;"></i>
	        </div>
	</sec:authorize>
    <div class="review-rating">
        <p id="animalhosp-rvcnt">리뷰</p>
        <p id="animalhosp-startotal">평점</p>
    </div>
	<div style="display: flex; justify-content: space-between;">
	    <a class="btn upd-btn" href="/review/list?animalhosp_no=${param.animalhosp_no }">리뷰보기</a>&nbsp;&nbsp;
	    <sec:authorize access="hasRole('ROLE_MEMBER')">
	        <div id="reserv-register" class="btn upd-btn">예약하기</div>&nbsp;&nbsp;
	    </sec:authorize>
	</div><br>
		
</div>

<div class="other-info place-container">
<h4>상세정보</h4>
    <p class="place-address" id="animalhosp-address">주소</p>
    <p></p><!-- 소재지 우편번호 - HSOP_POSTNUM NUMBER -->
    <p id="animalhosp-open"></p><!-- 영업시간 ANIMALHOSP_OPEN -->
    <p id="animalhosp-rest"></p><!-- 휴무일 ANIMALHOSP_REST -->
    <p id="animalhosp-phonenum"></p><!-- 전화번호 HSOP_PHONENUM -->
    <p id="animalhosp-latitude"></p><!-- WGS84 위도 - A_LATITUDE -->
    <p id="animalhosp-hardness"></p><!-- WGS84 경도 - A_HARDNESS -->
    <input type="hidden" id="csrfToken" name="${_csrf.parameterName}" value="${_csrf.token}" />
</div>
<!-- AJAX code -->
<c:set var="animalhosp_no" value="${param.animalhosp_no}" />
<sec:authorize access="isAuthenticated()">
	<input type="hidden" name="id" class="form-control" id="id" value='<sec:authentication property="principal.username"/>'>
</sec:authorize>
<script>

$(document).ready(function() {
    var animalhosp_no = "${animalhosp_no}"; // animalhosp_no 값 가져오기
    $.ajax({
        url: "/animalhosp/view",
        method: "GET",
        dataType: "json",
        data: { ano: animalhosp_no },
        success: function(response) {
            console.log(response);    
            var avo = response;
//             if (avo.animalhosp_pic) {
//                 var image = $('<img />', { 		// animalhosp_pic 값이 있는 경우에만 img 태그를 생성하고 추가
//                     src: avo.animalhosp_pic });
//                 $('.place-image').append(image);
//             } else {
//                 $('.place-image img').remove();	// animalhosp_pic 값이 null인 경우, img 태그를 제거
//             }
            $('#animalhosp-name').text(avo.animalhosp_name);
            $('#animalhosp-address').text(avo.hsop_roadname_address ? ("주소: " + avo.hsop_roadname_address) : "없음");
            $('#animalhosp-salesstatus').text("영업상태: " +avo.sales_status);
            $('#animalhosp-postnum').text("우편번호: " +avo.hsop_postnum);
            $('#animalhosp-latitude').text("위도: " +avo.a_latitude);            
            $('#animalhosp-hardness').text("경도: " +avo.a_hardness);
            $('#animalhosp-rvcnt').text(avo.rv_cnt ? ("리뷰: " + avo.rv_cnt + "개") : "리뷰: 없음");            
            $('#animalhosp-startotal').text(avo.star_total ? ("평점: " + avo.star_total/avo.rv_cnt) : "평점: 없음");
            $('#animalhosp-open').text(avo.animalhosp_open ? ("영업 시간: " + avo.animalhosp_open) : "영업 시간: 없음");
            $('#animalhosp-rest').text(avo.animalhosp_rest ? ("휴무일: " + avo.animalhosp_rest) : "휴무일: 없음");
            $('#animalhosp-phonenum').text(avo.hsop_phonenum ? ("전화 번호: " + avo.hsop_phonenum) : "전화 번호: 없음");
        },
        error: function(xhr, status, error) {
            console.error(error);
        }
    });
});

//즐겨찾기 유무 확인용
$(document).ready(function() {
    var animalhosp_no = "${animalhosp_no}";
    $.ajax({
    	 url: "/mark/markCnt",
        method: "GET",
        dataType: "json",
        data: { animalhosp_no : animalhosp_no },
        success: function(response) {
            if(response == 0) {//값이 없을때
            	console.log(response);
                $('#reserv-favorite').removeClass('active');
            } else {
            	console.log(response);
                $('#reserv-favorite').addClass('active');
            }
        },
        error: function(xhr, status, error) {
            console.error(error);
        }
    });
});

document.getElementById("animalhosp-rvcnt").addEventListener("click", function() {
    var animalhosp_no = "${param.animalhosp_no}"; 
    var url = "/review/list?animalhosp_no=" + animalhosp_no;
    window.location.href = url;
});

document.getElementById("reserv-register").addEventListener("click", function() {
    var animalhosp_no = "${param.animalhosp_no}"; 
    var url = "/reserv/register?hno=" + animalhosp_no;
    window.location.href = url;
});


$('#reserv-favorite').click(function() {
    var animalhosp_no = "${animalhosp_no}";
    var userId = $("#id").val();
    var header = "${_csrf.headerName}";
    var token = "${_csrf.token}";
    
    if (!$(this).hasClass('active')) { // .active 클래스가 없는 경우에만 실행 
        $.ajax({
            url: "/mark/register",
            type: "POST",
            beforeSend: function(xhr) {
                xhr.setRequestHeader(header, token);
            },
            data: JSON.stringify({
                id: userId,
                animalhosp_no: animalhosp_no
            }),
            contentType: "application/json; charset=utf-8",
            success: function(response) {
                console.log(response);
                // 성공한 경우에만 .active 클래스를 추가하고 꽉 찬 하트로 바꿈
                $('#reserv-favorite').addClass('active');
            },
            error: function(xhr, status, error) {
                console.error(error);
            }
        });
    }
    else{
        $.ajax({
            url: "/mark/remove", 
            type: "POST",
            beforeSend: function(xhr) {
                xhr.setRequestHeader(header, token);
            },
            data: JSON.stringify({
                id: userId,
                animalhosp_no: animalhosp_no
            }),
            contentType: "application/json; charset=utf-8",
            success: function(response) {
                console.log(response);
                // 성공한 경우에만 .active 클래스를 제거하고 빈 하트로 바꿈
                $('#reserv-favorite').removeClass('active');
            },
            error: function(xhr, status, error) {
                console.error(error);
            }
        });
    }
});
</script>
<!-- AJAX code End-->
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
</body>
</html>