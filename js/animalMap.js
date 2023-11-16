var debounceTimeout;
var debounceDelay = 2000;  // 500ms
var zoomControl = new kakao.maps.ZoomControl();
map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
kakao.maps.event.addListener(map, 'center_changed', loadHospitalDataDebounced);
kakao.maps.event.addListener(map, 'zoom_changed', loadHospitalDataDebounced);

function loadHospitalData(pageNum, aLatitude, aHardness) {
        $.ajax({
            url: "/animalhosp/selectbymap", // 컨트롤러의 URL
            method: "GET",
            dataType: 'json', 
            data: { 
                pageNum: pageNum,
                amount: 10,
                aLatitude: aLatitude,
                aHardness: aHardness
            },
            success:function(response){
                console.log(response);
                var hospitals = response.hospitals; 
                addMarkersToMap(hospitals); // 병원 위치에 마커 추가
                 var pageMaker = response.pageMaker;
                 var start = pageMaker.start;
                 var end = pageMaker.end;
                 var prev = pageMaker.prev;
                 var next = pageMaker.next;

				$("#hospitalList").empty();
				for(var i=0; i<hospitals.length; i++){
				    let div = document.createElement('div');
				    div.className = "hospitalItem";
				    div.innerHTML = "<p>No: "+hospitals[i]['animalhosp_no']+"</p>"+
				                    "<p class='hospital-name' data-a_latitude='"+hospitals[i]['a_latitude']+"'data-a_hardness='"+hospitals[i]['a_hardness']+"'>Name: "+hospitals[i]['animalhosp_name']+"</p>"+
				                    "<p>Address: "+hospitals[i]['hsop_roadname_address']+"</p>"+
				                    "<p><a href='animalhospView?animalhosp_no="+hospitals[i]['animalhosp_no']+"'>Detail</a></p>";
				    $("#hospitalList").append(div);
				}
                $("#pagination").empty().removeClass('justify-content-end').addClass('justify-content-start');
                  if (prev) {
                      $("#pagination").append('<li class="page-item"><a href="#" class="page-link" data-page="' + (start - 1) + '">&laquo; Previous</a></li>');
                  }              
                  for (var i=start; i<=end; i++) {
                      let activeClass=i===pageNum?'active':'';
                      $("#pagination").append('<li class="page-item '+activeClass+'"><a href="#" class="page-link" data-page="' +i+'">'+i+'</a></li>');
                   }
                   if(next){
                       $("#pagination").append('<li class="page-item"><a href="#" class="page-link" data-page="' +(end+1)+'">Next &raquo;</a></li>');
                   }
            },
            error:function(xhr,status,error){
               console.error(error);
            }
        });
    }

$(document).ready(function() {
   loadHospitalData(1,37.52436106,127.0205623); // 페이지 로드 시 첫 번째 페이지 데이터 불러오기
   $(document).on('click', '#pagination a', function(e) {//페이징 클릭시 데이터를 불러옴
        e.preventDefault();
        var pageNum = $(this).data('page');
        var latlng = map.getCenter(); 
        loadHospitalData(pageNum, latlng.getLat(), latlng.getLng());
   });
});

function addMarkersToMap(hospitals) {
  for (let i = 0; i < hospitals.length; i++) {
    var markerPosition = new kakao.maps.LatLng(hospitals[i].a_latitude, hospitals[i].a_hardness);
    var marker = new kakao.maps.Marker({
      position: markerPosition,
    });
    marker.setMap(map);
  }
}


// 지도 중심 좌표 변화
kakao.maps.event.addListener(map, 'center_changed', function() {
    var latlng = map.getCenter(); 
    loadHospitalData(1, latlng.getLat(), latlng.getLng()); // 첫 페이지의 데이터를 불러옵니다.
});

function loadHospitalDataDebounced() {//늦추기
    clearTimeout(debounceTimeout);  // 이전 타임아웃 삭제
    debounceTimeout = setTimeout(function() {
        var latlng = map.getCenter(); 
        loadHospitalData(1, latlng.getLat(), latlng.getLng());
    }, debounceDelay);  // 새 타임아웃 설정
}

// 지도를 표시하는 div 크기를 변경하는 함수입니다
function resizeMap() {
    var mapContainer = document.getElementById('map');
    mapContainer.style.width = '650px';
    mapContainer.style.height = '650px'; 
}

function relayout() {    
    // 지도를 표시하는 div 크기를 변경한 이후 지도가 정상적으로 표출되지 않을 수도 있습니다
    // 크기를 변경한 이후에는 반드시  map.relayout 함수를 호출해야 합니다 
    // window의 resize 이벤트에 의한 크기변경은 map.relayout 함수가 자동으로 호출됩니다
    map.relayout();
}

document.getElementById('search-button').addEventListener('click', function() {
		var a_latitude = document.getElementById('addr_latitude').value;
		 var a_hardness =  document.getElementById('addr_hardness').value;    
		map.setCenter(new kakao.maps.LatLng(a_latitude, a_hardness));
});










