<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html>
<html>
<head>
<style>
#panel {
  position: fixed; 
  left: -500px; 
  top: 0; 
  width: 500px; 
  height: 100%; 
  background: #fff;
  padding: 20px;
  font-size: 14px;
  border-radius: 0 10px 10px 0;
}

</style>
	<title>PetMap</title>
	<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=0m8ewuqf7h"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

</head>


<body onload="if (isLoggedIn) { loadLikedPlaces(); }">


<%@ include file="../includes/header.jsp"%>

<script>

    var petmap = [];
    <c:choose>
        <c:when test="${isList}">
            <c:forEach var='item' items='${petmap}'>
                <c:if test="${item.lcLa != null && item.lcLo != null}">
                    petmap.push(
                        { 
                            lat: ${item.lcLa}, 
                            lng: ${item.lcLo}
                        }
                    );
                </c:if>
            </c:forEach>
        </c:when>
        <c:otherwise>
            petmap = {
                lat: ${petmap.lcLa}, 
                lng: ${petmap.lcLo}
            };
        </c:otherwise>
    </c:choose>
</script>

<div id='map' style='width:100%; height:800px;'></div>

<!-- 슬라이드 패널 -->
<div id="panel" style="position:fixed; left:-500px; top:0; width:500px; height:100%; background:#fff;">
<div id="panel-content" style="padding-left: 30px;">

</div>
</div>

<script type='text/javascript'>
var isLoggedIn = ${empty principal ? 'false' : 'true'}; // 로그인 여부
var likedPlaces = []; // 좋아요한 장소 정보를 담을 배열

if (isLoggedIn) {
    // 로그인한 사용자인 경우
    loadLikedPlaces(); // 좋아요한 장소 정보를 로드
}

var mapOptions = {
    center: new naver.maps.LatLng(37.55659941294486, 126.91950704548246), // 초기 지도 중심 좌표 설정
    zoom: 15
};

var map = new naver.maps.Map('map', mapOptions);

var previousMarker = null; // 이전에 클릭한 마커를 저장하는 변수
var panelIsOpen = false; // 패널의 상태(열림 또는 닫힘)를 나타내는 변수

for (var i = 0; i < petmap.length; i++) {
    var markerOptions = {
        position: new naver.maps.LatLng(petmap[i].lat, petmap[i].lng),
        map: map
    };

    var marker = new naver.maps.Marker(markerOptions);
    var placeNo = '';

    (function (marker) {
        // 클릭 이벤트 리스너 추가
                    loadLikedPlaces();

        naver.maps.Event.addListener(marker, "click", function (e) {
            if (previousMarker !== marker) {
                // 이전에 클릭한 마커와 다른 마커를 클릭한 경우에만 패널 내용을 업데이트
                updatePanelContent(marker.getPosition().lat(), marker.getPosition().lng());
                $('#panel').animate({ left: '0' }, 500);

                previousMarker = marker; // 이전 마커 정보를 저장

                if (!panelIsOpen) {
                    // 이전 마커 정보와 현재 마커 정보가 다르고 패널이 닫힌 상태일 때 패널을 열기
                    openPanel();
                } else {
                    // 이전 마커 정보가 없고, 패널이 열린 상태일 때 패널을 닫기
                    $('#panel').animate({ left: '0' }, 500);
                }
            } else if (previousMarker === marker && panelIsOpen) {
                // 이전과 같은 마커를 클릭하고 패널이 열린 상태인 경우, 패널을 닫음
                closePanel();
            } else {
                // 이전과 같은 마커를 클릭하고 패널이 닫힌 상태인 경우, 패널을 엶
                openPanel();
            }
        });
    })(marker);
}

function openPanel() {
    $('#panel').animate({ left: '0' }, 500);
    panelIsOpen = true;
}

function closePanel() {
    $('#panel').animate({ left: '-500px' }, 500);
    panelIsOpen = false;
}



//좋아요 버튼 클릭 시 이벤트 핸들러
$(document).on('click', '.likeButton', async function () {
    var likeButton = $(this);
    var isLiked = likeButton.hasClass("liked");
    var placeNo = likeButton.data('place-no');
    if (isLiked) {
        await removeLike(placeNo);
        likeButton.removeClass("liked").css("color", "white");
    } else {
        await addLike(placeNo);
        likeButton.addClass("liked").css("color", "#F08080");
    }
    loadLikedPlaces(); // 좋아요 상태를 변경한 후에 좋아요한 장소 정보를 최신 상태로 업데이트
});

function addLike(placeNo) {
    var csrfHeaderName = '${_csrf.headerName}';
    var csrfTokenValue = '${_csrf.token}';

    return $.ajax({
        url: '/like/add',
        type: 'POST',
        data: { "placeNo": placeNo },
        dataType: "json",
        beforeSend: function (xhr) {
            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
        },
        success: function (result) {
            likedPlaces.push(placeNo);
            console.log(result);
            
            // 디버깅을 위한 출력
            console.log("placeNo in addLike: ", placeNo);
            console.log("likedPlaces after adding: ", likedPlaces);

            // 좋아요가 추가된 후에 likedPlaces 배열을 최신 상태로 업데이트
            loadLikedPlaces();
        },
        error: function (xhr, status, error) {
            if (xhr.status == 401) {
                alert(xhr.responseText);
            } else {
                console.error(xhr.responseText);
            }
        }
    });
}

function removeLike(placeNo) {
    // 추가 코드: 좋아요 상태를 서버에서 제거하는 함수
    var csrfHeaderName = '${_csrf.headerName}';
    var csrfTokenValue = '${_csrf.token}';

    return $.ajax({
        url: '/like/remove',
        type: 'POST',
        data: { "placeNo": placeNo },
        dataType: "json",
        beforeSend: function (xhr) {
            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
        },
        success: function (result) {
            console.log(result);
            var index = likedPlaces.indexOf(placeNo);
            if (index > -1) {
                likedPlaces.splice(index, 1);
            }
        },
        error: function (xhr, status, error) {
            console.error(xhr.responseText);
        }
    });
}

function updatePanelContent(lat, lng) {
    // 추가 코드: 패널 열릴 때마다 서버에서 최신 정보를 가져오는 함수
    $.ajax({
        url: '/petmap/info',
        type: 'GET',
        data: { lat: lat, lng: lng },
        dataType: 'json',
        success: function (petmapData) {
            var placeNo = petmapData.placeNo;
            var isLiked = likedPlaces.includes(placeNo);
            document.getElementById('panel-content').innerHTML =
                '<br><br><br><br><br><br><h4>' + (petmapData.fcltyNm || '문의 바람') +
                '<button id="likeBtn" class="likeButton' + (isLiked ? ' liked' : '') + '" data-place-no="' + placeNo + '" style="border-radius: 60%; border: none; color: ' + (isLiked ? '#F08080' : 'white') + ';">❤︎</button></h4>' +
                '<p><span style="color:gray;">' + (petmapData.ctgryTwoNm || '') + ' ' + (petmapData.ctgryThreeNm || '') + '</span></p>' +
                '<hr />' +
                '<p>주소:' + '<br>' + petmapData.zipNo + '<br>' + (petmapData.rdnmadrNm || '') + '<br>' + (petmapData.lnmAddr || '') + '</p>' +
                '<p>영업시간:' + (petmapData.operTime || '문의 바람') + '</p>' +
                '<p>전화번호:' + (petmapData.telNo || '문의 바람') + '</p>' +
                '<a ' + ((petmapData.hmpgUrl !== undefined && petmapData.hmpgUrl != null) ? ('href="' + petmapData.hmpgUrl + '" target="_blank"') : '') + '>홈페이지 링크</a>' +
                '<p>휴무일 안내내용:' + (petmapData.rstdeGuidCn || '문의 바람') + '</p>' +
                '<p>주차 가능 여부:' + ((typeof petmapData.parkngPosblAt !== "undefined" && petmapData.parkngPosblAt != null) ? petmapData.parkngPosblAt : '문의바랍니다.') + '</p>' +
                "<p>이용가격:" + ((typeof petmapData.utiliizaPrcCn !== "undefined" && petmapData.utiliizaPrcCn != null) ? petmapData.utiliizaPrcCn : "문의바랍니다.") + '</p>' +
                "<p>반려동물 제한 사항:" + ((typeof petmapData.petLmttMtrCn !== "undefined" && petmapData.petLmttMtrCn != null) ? petmapData.petLmttMtrCn : "문의바랍니다.") + '</p>';
         

            console.log('updatePanelContent: success');
            console.log('isLiked:', isLiked);
        },
        error: function (request, status, error) {
            console.error('updatePanelContent: error');
            console.error("code:" + request.status + " message:" + request.responseText + " error:" + error);
            console.error(xhr.responseText);
        }
    });
}

function loadLikedPlaces() {
    // 추가 코드: 로그인한 사용자의 좋아요한 장소 정보를 로드하는 함수
    $.ajax({
        url: '/like/likes',
        type: 'GET',
        dataType: 'json',
        success: function (data) {
            likedPlaces = data;
            // 디버깅 정보 출력
            console.log('loadLikedPlaces: success');
            console.log('likedPlaces:', likedPlaces);
        },
        error: function (request, status, error) {
            alert("code:" + request.status + " message:" + request.responseText + " error:" + error);
            console.error('loadLikedPlaces: error');
            console.error("code:" + request.status + " message:" + request.responseText + " error:" + error);
        }
    });
}
</script>
<%@ include file="../includes/footer.jsp"%>
</body>
</html>