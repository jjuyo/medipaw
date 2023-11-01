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

</head>

<body>

<%@ include file="../includes/header.jsp"%>
<script>
    var petmap = [];
    <c:choose>
        <c:when test="${isList}">
            <c:forEach var='item' items='${petmap}'>
                petmap.push(
                    { 
                        lat: ${item.lcLa}, 
                        lng: ${item.lcLo},
                    }
                );
            </c:forEach>
        </c:when>
        <c:otherwise>
            petmap = {
                lat: ${petmap.lcLa}, 
                lng: ${petmap.lcLo},
            };
        </c:otherwise>
    </c:choose>
</script>

<div id='map' style='width:100%; height:800px;'></div>

<!-- 슬라이드 패널 -->
<div id="panel" style="position:fixed; left:-500px; top:0; width:500px; height:100%; background:#fff;">
<div id="panel-content" style="padding-left: 30px;">
${item.zip_no} ${item.zipNo }
</div>
</div>

<script type='text/javascript'>
    var mapOptions = {
        center: new naver.maps.LatLng(37.55659941294486, 126.91950704548246 ), // 초기 지도 중심 좌표 설정
        zoom: 15
    };

    var map = new naver.maps.Map('map', mapOptions);

    for (var i = 0; i < petmap.length; i++) {
        var markerOptions = {
            position:
	new naver.maps.LatLng(petmap[i].lat, petmap[i].lng),
            map:
	map
        };
        
        var marker = new naver.maps.Marker(markerOptions);
        
       (function(marker) {
           // 클릭 이벤트 리스너 추가
           naver.maps.Event.addListener(marker, "click", function(e) {
			var fcltyNm = '${item.fclty_nm}';
               $.ajax({
                   url : '/petmap/info',
                   type : 'GET',
                   data : { lat : marker.getPosition().lat(), lng : marker.getPosition().lng() },
                   dataType: 'json', // 명시적으로 JSON 데이터를 받을 것임을 지정
                   success : function(petmap){
                       document.getElementById('panel-content').innerHTML =
                            '<br><br><br><br><br><br><h4>' + (petmap.fcltyNm || '문의 바람') + '</h4>' +
                            '<p><span style="color:gray;">' + (petmap.ctgryTwoNm || '') + ' ' + (petmap.ctgryThreeNm || '')  + '</span></p>' +
                            '<hr />' +
                            '<p>주소:' + '<br>'+ petmap.zipNo +'<br>'+ (petmap.rdnmadrNm || '')+ '<br>'+ (petmap.lnmAddr || '')+'</p>'+
                            '<p>영업시간:' +(petmap.operTime||'문의 바람')+ '</p>'+
                            '<p>전화번호:' +(petmap.tel_no||'문의 바람')+ '</p>'+
                            '<a ' + ((petmap.hmpgUrl !== undefined && petmap.hmpgUrl != null)? ('href="'+ petmap.hmpgUrl+'" target="_blank"') : '') + '>홈페이지 링크</a>' +
                            '<p>휴무일 안내내용:'+(petmap.rstdeGuidCn||'문의 바람')+ '</p>'+
                            '<p>주차 가능 여부:'+((typeof petmap.parkngPosblAt !== "undefined" && petmap.parkngPosblAt != null)? petmap.parkngPosblAt : '문의바랍니다.')+'</p>'+  
        	                "<p>이용가격:"+((typeof petmap.utiliizaPrcCn !== "undefined" && petmap.utiliizaPrcCn != null)? petmap.utiliizaPrcCn : "문의바랍니다.")+'</p>'+   
        	                "<p>반려동물 제한 사항:"+((typeof petmap.petLmttMtrCn !== "undefined" && petmap.petLmttMtrCn != null)? petmap.petLmttMtrCn : "문의바랍니다.") +'</p>';

                       $('#panel').animate({left:'0'}, 500);
                   },
                   error:function(request,status,error){
                       alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                   }
               });
           });
       })(marker);
    }
    
    $(document).on('click', function (e) {
        if ($(e.target).closest('#panel').length === 0) {
            $('#panel').animate({left:'-500px'}, 500);
        }
    }); 	
</script>
<%@ include file="../includes/footer.jsp"%>
</body>
</html>