<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<html>
<head>
<meta charset="UTF-8">
<title>Hospital List</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src= "https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="/resources/js/animalAddr_ver2.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<style>
    body {
        padding-top: 80px; /* í¤ëì ëì´ë§í¼ ìë¨ í¨ë© ì¶ê° */
    }
.search-container {
    display: flex;
    padding-top: 80px;
    justify-content: space-between;
    width: 100%; /* ëë¹ë¥¼ 100%ë¡ ì¤ì  */
}
.col-md-3, .col-md-9 {
    padding: 0 15px; /* ì¢ì° í¨ë© ê° ì¡°ì  */
}
#search-input {
    flex-grow: 1;
    padding: 5px;
}

#search-button {
    margin-left: 10px;
}
.hospital-item {
	margin-bottom: 20px;
}
.hospitalItem {
	border-bottom: 1px solid #ccc;
	padding: 10px;
	background-color: rgba(255, 255, 255, 0.7);
	backdrop-filter: blur(10px);
}
#hospitalList {
	overflow-y: auto;
	height: calc(100vh - (2em + 56px));
	backdrop-filter: blur(10px);
}
body, html {
	height: 100%;
	margin: 0;
	padding: 0;
}

.container {
	height: 100%;
}

#map {
    width: auto;
    height: calc(100% - 56px); /* 헤더의 실제 높이에 따라 조정하세요 */
    margin-bottom: 10px; /* 맵과 footer 사이의 간격 조정 */
}

footer {
    margin-top: 150px; /* 맵과 footer 사이의 간격 조정 */
}
</style>
</head>
<body>
<div class='container-fluid' style="height: calc(100vh - 56px); padding-top: 56px;">
    <div class='row'>
        <!-- Left Column - Search and Hospital List -->
        <div class="search-container" style="position: relative; z-index: 9999;">
            <div class="container-fluid">
                <div class="row">
	                <div class="col-md-4 p-3">
	                    <input type="text" onclick="sample4_execDaumPostcode()" id="hsop_roadname_address" placeholder="...">
	                    <button id="search-button">Search</button>
	                </div>
                </div>
            </div>
        </div>
        <div class='col-md-3 p-3' style="height: 100%; overflow: visible;">
            <!-- Add your search form here -->
            <div id="hospitalList"></div>
            <!-- Pagination links will be added dynamically by JavaScript -->
            <ul id="pagination" class="pagination justify-content-end"></ul><!-- End Paging --> 
            <input type="hidden" id="addr_latitude" value="defalut">
            <input type="hidden" id="addr_hardness" value="defalut">
        </div><!-- End Left Column -->

        <!-- Right Column - Map --> 
        <div class='col-md-9 p-0'>
            <div id="map"></div>    
            <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=324cb7fd34303372c49d32287955fde6&libraries=services"></script>
            <script type="text/javascript">
                var mapContainer = document.getElementById('map');
                var mapOption ={
                    center:new kakao.maps.LatLng(37.52436106,127.0205623),
                    level :3
                };
                var map=new kakao.maps.Map(mapContainer,mapOption);    
            </script>
            <script>
              $("#hospitalList").on("click", ".hospital-name", function() {
                    var a_latitude = $(this).data('a_latitude');
                    var a_hardness = $(this).data('a_hardness');
                    map.setCenter(new kakao.maps.LatLng(a_latitude, a_hardness));
                });
            </script>
            <script src="/resources/js/animalMap.js"></script>    
        </div><!-- End Right Column --> 
    </div><!-- End Row -->  
</div><!-- End Container -->

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
</body>
</html>