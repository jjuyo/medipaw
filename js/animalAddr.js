$(document).ready(function() {
var selectedDays = [];
        $(".day").on("click", function() {
            var day = $(this).text();
            if($(this).hasClass("selected")) {
                $(this).removeClass("selected");
                var index = selectedDays.indexOf(day);
                if(index > -1) {
                    selectedDays.splice(index, 1);
                }
            } else {
                $(this).addClass("selected");
                selectedDays.push(day);
            }
            $("#selectedDays").val(selectedDays.join(","));
        });
});

function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {    
             			var roadAddr = data.roadAddress; // 도로명 주소 변수
		                var extraRoadAddr = ''; // 참고 항목 변수
		
		                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                    extraRoadAddr += data.bname;
		                }
		                // 건물명이 있고, 공동주택일 경우 추가한다.
		                if(data.buildingName !== '' && data.apartment === 'Y'){
		                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                }
		                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		                if(extraRoadAddr !== ''){
		                    extraRoadAddr = ' (' + extraRoadAddr + ')';
		                }
		
		                // 우편번호와 주소 정보를 해당 필드에 넣는다.
		                document.getElementById('hsop_postnum').value = data.zonecode;
		                document.getElementById("hsop_roadname_address").value = roadAddr;
		                //document.getElementById("u_roadAddress").value += extraRoadAddr;

            var geocoder = new kakao.maps.services.Geocoder();

            var callback = function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    console.log(result);
                    if (result.length > 0 && result[0].hasOwnProperty('y')) {
                        document.getElementById('a_latitude').value = result[0].y;
                        document.getElementById('a_hardness').value = result[0].x;               
                    }
                }
            };
            var userAddress = data.roadAddress || data.jibunAddress;
            geocoder.addressSearch(userAddress, callback);                
          }//oncomplete end
      }).open();
 }
 
function mergeTimeFields() {
    var openTime = document.getElementById('animalhosp_start').value;
    var closeTime = document.getElementById('animalhosp_close').value;
    var mergedTime = openTime + ' ~ ' + closeTime;
    document.getElementById('animalhosp_open').value = mergedTime;
    return true;
}