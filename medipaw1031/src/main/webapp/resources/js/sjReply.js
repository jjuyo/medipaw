/**
 * 	/resources/js/sjReply.js
 */
 
var replyService = ( function(){
	
	// 댓글 등록 --------------------------
	function add(sjReply, callback) {							// 여기서 쓰는 sjReply는 SiljongReplyVO를 받아온다!
		$.ajax({
			type : 'post',										// get or post
			url : '/sjreply/add',								// 전송할 곳 action
			data : JSON.stringify(sjReply),						// 전송할 데이터
			contentType : 'application/json; charset=UTF-8',	// 컨텐트 타입 및 인코딩
			success : function(result, status, xhr) {			// 성공 시 처리
				if(callback){									// success와 상태코드 받기
					callback(result);							// result는 view.jsp로 넘어감
				}												// 콜백 함수는 주도권을 호출한 쪽으로 넘겨줌
			},	
			error : function(xhr, status, er) {					// 실패 시 처리
				if(error){
					error(er);
				}
			}		
		});	// ajax END	
	} // 댓글 등록 END	--------------------
	
	// 댓글 목록 --------------------------
	function list(param, callback, error) {						// ajax 써도 되고 json데이터 받기만 해서 getJSON 써도 됨
		$.getJSON('/sjreply/pages/' + param.sjno + '/' + param.pageNum + '.json',		
			function(result){									// 잘 받아와서 성공 시
				if(callback){									// ajax 코드와 하는 일은 같음
					callback(result.replyCnt, result.list);		// 따로 받을 수 있음
				}
			}
		).fail(function(){										// 실패 시
			if(error){
				error(er);
			}
		});
	} // 댓글 목록 END --------------------
	
	// 댓글 수정 --------------------------
	function modify(sjReply, callback, error) {					// 여기서 쓰는 sjReply는 SiljongReplyVO를 받아온다!
		$.ajax({
			type : 'put',										// method
			url : '/sjreply/' + sjReply.sjrno,					// 전송할 곳 action
			data : JSON.stringify(sjReply),						// 전송할 데이터
			contentType : 'application/json; charset=UTF-8',	// 컨텐트 타입 및 인코딩
			success : function(result, status, xhr) {			// 성공 시 처리
				if(callback){									// success와 상태코드 받기
					callback(result);							// result는 view.jsp로 넘어감
				}												// 콜백 함수는 주도권을 호출한 쪽으로 넘겨줌
			},	
			error : function(xhr, status, er) {					// 실패 시 처리
				if(error){
					error(er);
				}
			}		
		});	// ajax END	
	} // 댓글 수정 END	--------------------
	
	// 댓글 삭제 --------------------------
	function remove(sjrno, callback, error) {					
		$.ajax({												
			type : 'delete',									// method
			url : '/sjreply/' + sjrno,							// 전송할 곳 action
			success : function(result, status, xhr) {			// 성공 시 처리
				if(callback){									// success와 상태코드 받기
					callback(result);							// result는 view.jsp로 넘어감
				}												// 콜백 함수는 주도권을 호출한 쪽으로 넘겨줌
			},	
			error : function(xhr, status, er) {					// 실패 시 처리
				if(error){
					error(er);
				}
			}		
		}); // ajax END	
	} // 댓글 삭제 END	--------------------
	
	// 댓글 1개 조회 --------------------------
	function view(sjrno, callback, error) {						// ajax 써도 되고 json데이터 받기만 해서 getJSON 써도 됨
		$.get('/sjreply/' + sjrno + '.json',		
			function(result){									// 잘 받아와서 성공 시
				if(callback){									// ajax 코드와 하는 일은 같음
					callback(result);							
				}
			}
		).fail(function(){										// 실패 시
			if(error){
				error(er);
			}
		});
	} // 댓글 1개 조회 END --------------------
	
	// 날짜 및 시간 출력 포맷
	function display(regDate){
		var rDate = new Date(regDate);
	    var today = new Date();
	
		var hours = rDate.getHours();
        var minutes = rDate.getMinutes();
        var seconds = rDate.getSeconds();
        var year = rDate.getFullYear();
        var month = rDate.getMonth() + 1;
        var day = rDate.getDate();
        
	    if (rDate.getDate() == today.getDate()) {	// 오늘과 시간 비교하기
	        // 오늘 날짜인 경우 시간만 표시
	        // var time = (hours < 10 ? "0" : "") + hours + ":" + (minutes < 10 ? "0" : "") + minutes + ":" + (seconds < 10 ? "0" : "") + seconds;
	        return [ (hours < 10 ? '0' : '')   + hours, ':', 
	        		 (minutes < 10 ? '0' : '') + minutes, ':', 
	        		 (seconds < 10 ? '0' : '') + seconds ].join('');
	    } else {
	        // 오늘 날짜가 아닌 경우 연월일 표시
	        // var date = year + "-" + (month < 10 ? "0" : "") + month + "-" + (day < 10 ? "0" : "") + day;
	        return [ year, '-', (month < 10 ? "0" : "") + month , '-', (day < 10 ? "0" : "") + day ].join('');
	    }
	
	} // 날짜 및 시간 출력 포맷 END
	
	
	return { display:display, add:add, list:list, modify:modify, remove:remove, view:view }; // 처음 콘솔에 {add: ƒ} 찍힘
	// 함수들을 여기서 반환해야 view.jsp에서 사용할 수 있음
})();	// () -> 즉시 실행 함수	
 
 