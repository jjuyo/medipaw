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
  height: calc(100% - 100px); /* 화면 높이에서 푸터 높이를 뺀 값으로 설정 */
  background: #fff;
  padding: 20px;
  padding-top: 150px; /* 상단 여백 추가 */
  font-size: 9px;
  border-radius: 0 10px 10px 0;
}

#panel-content {
  overflow: auto; /* 스크롤 추가 */
  height: 100%; /* 높이를 100%로 설정하여 전체 패널을 채우도록 함 */
  padding-left: 30px;
}
</style>
	<title>My PetMap</title>
	<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=0m8ewuqf7h"></script>
</head>
<body>
<%@ include file="../includes/header.jsp"%>

<script>
    var userLikes = [];
    <%-- 로그인한 사용자가 찜한 장소들의 정보를 가져옴 --%>
    <c:forEach var='item' items='${userLikes}'>
        <c:if test="${item.lcLa != null && item.lcLo != null}">
        userLikes.push(
                { 
                    lat: ${item.lcLa}, 
                    lng: ${item.lcLo},
                    placeNo: ${item.placeNo},
                    fcltyNm: "${item.fcltyNm}",
                    ctgryTwoNm: "${item.ctgryTwoNm}",
                    ctgryThreeNm: "${item.ctgryThreeNm}"
                }
            );
        </c:if>
    </c:forEach>

 
</script>
    

<div id='map' style='width:100%; height:800px;'></div>

<!-- 슬라이드 패널 -->
<div id="panel" style="position:fixed; left:-500px; top:0; width:500px; height:100%; background:#fff;">
<div id="panel-content" style="padding-left: 30px;">

</div>
</div>

<script type='text/javascript'>
    var mapOptions = {
        center: new naver.maps.LatLng(37.55659941294486, 126.91950704548246 ), // 초기 지도 중심 좌표 설정
        zoom: 15
    };

    var map = new naver.maps.Map('map', mapOptions);

    for (var i = 0; i < userLikes.length; i++) {
        var markerOptions = {
            position: new naver.maps.LatLng(userLikes[i].lat, userLikes[i].lng),
            map: map
        };

        var marker = new naver.maps.Marker(markerOptions);

        // 마커에 클릭 이벤트 리스너를 추가합니다.
        naver.maps.Event.addListener(marker, 'click', function() {
            $('#panel').animate({left:'0'}, 500);
        });
    }

    $(document).ready(function() {
        var panelContent = '';
        for (var i = 0; i < userLikes.length; i++) {
            panelContent +=
                '<div class="likeItem" data-lat="' + userLikes[i].lat + '" data-lng="' + userLikes[i].lng + '" data-placeNo="' + userLikes[i].placeNo + '">' +
                '<h6>' + (userLikes[i].fcltyNm || '문의 바람') + 
                '<p><span style="color:gray;">' + (userLikes[i].ctgryTwoNm || '') + ' ' + (userLikes[i].ctgryThreeNm || '')  + '</span></p>' +
                '<hr /></div>';
        }
        document.getElementById('panel-content').innerHTML = panelContent;
    });

    $(document).on('click', '.likeItem', function() {
        var lat = $(this).data('lat');
        var lng = $(this).data('lng');
        map.panTo(new naver.maps.LatLng(lat, lng));
    });


</script>
<%@ include file="../includes/footer.jsp"%>
</body>
</html>