function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {    
             			var roadAddr = data.roadAddress; // 도로명 주소 변수
		                var extraRoadAddr = ''; // 참고 항목 변수
		                
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
					document.getElementById("hsop_roadname_address").value = roadAddr;

		            var geocoder = new kakao.maps.services.Geocoder();
		
		            var callback = function(result, status) {
		                if (status === kakao.maps.services.Status.OK) {
		                    console.log(result);
		                    if (result.length > 0 && result[0].hasOwnProperty('y')) {
		                        document.getElementById('addr_latitude').value = result[0].y;
		                        document.getElementById('addr_hardness').value = result[0].x;               
		                    }
		                }
		            };
		            var userAddress = data.roadAddress || data.jibunAddress;
		            geocoder.addressSearch(userAddress, callback);                
          }//oncomplete end
      }).open();
 }