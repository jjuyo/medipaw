var replyService = ( function(){
//날짜 포맷
//날짜 및 시간 출력 포맷
function display(regDate){
var today = new Date();
var rDate = new Date(regDate);

    if (today.getFullYear() === rDate.getFullYear() &&
        today.getMonth() === rDate.getMonth() &&
        today.getDate() === rDate.getDate()) {
        // 오늘 작성한 댓글의 경우 시:분:초 형식으로 반환
        return [
            (rDate.getHours() < 10 ? '0' : '') + rDate.getHours(),
            ':',
            (rDate.getMinutes() < 10 ? '0' : '') + rDate.getMinutes(),
            ':',
            (rDate.getSeconds() < 10 ? '0' : '') + rDate.getSeconds()
        ].join('');
    } else {
        // 그렇지 않으면 연/월/일 형식으로 반환
        return [
            rDate.getFullYear(),
            '/',
            ((rDate.getMonth() + 1) < 10 ? '0' : '') + (rDate.getMonth() + 1),
            '/',
            (rDate.getDate() < 10 ? '0' : '') + rDate.getDate()
        ].join('');
    }
}//end
//댓글삭제--------
function remove(byrno, callback, error){
	$.ajax({
			type : 'delete', //get | post
			url : '/byReply/'+ byrno ,	//전송할 곳 
			success : function(result, status, xhr){
								if(callback){
								callback(result);
								}
							},	//성공 시
			error: function(xhr, status, er){
						if(error){
						error(er);
						}
					}	//에러 시
			}); //END ajax()---
}//END 댓글 삭제-----

//댓글수정--------
function modify(reply, callback, error){
	$.ajax({
			type : 'put', //get | post
			url : '/byReply/'+reply.byrno ,	//전송할 곳 
			data : JSON.stringify(reply),	//전송할 데이터
			contentType : 'application/json; charset=UTF-8',	//컨텐트 타입 및 인코딩
			success : function(result, status, xhr){
								if(callback){
								callback(result);
								}
							},	//성공 시
			error: function(xhr, status, er){
						if(error){
						error(er);
						}
					}	//에러 시
			}); //END ajax()---
}//END 댓글 수정-----

//댓글목록------------
function list(param, callback, error){
	$.getJSON('/byReply/pages/'+ param.byno +'/'+ param.pageNum +'.json',
					function(result){
							if(callback){
									callback(result.replyCnt, result.list);
							}
					}
		).fail(function(){
						if(error){
							error(er);
						}
		});

}//END 댓글목록-----------

//댓글조회------------
function view(byrno, callback, error){
	$.get('/byReply/'+byrno+'.json',
					function(result){
							if(callback){
									callback(result);
							}
					}
		).fail(function(xhr, status, er){
						if(error){
							error(er);
						}
		});

}//END 댓글조회-----------

//댓글등록--------
function add(reply, callback, error){
	$.ajax({
			type : 'post', //get | post
			url : '/byReply/add' ,	//전송할 곳 
			data : JSON.stringify(reply),	//전송할 데이터
			contentType : 'application/json; charset=UTF-8',	//컨텐트 타입 및 인코딩
			success : function(result, status, xhr){
								if(callback){
								callback(result);
								}
							},	//성공 시
			error: function(xhr, status, er){
						if(error){
						error(er);
						}
					}	//에러 시
			}); //END ajax()---
}//END 댓글 등록-----
	return {add:add, list:list, modify:modify, remove:remove, view:view, display:display};
})();