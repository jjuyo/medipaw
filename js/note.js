document.addEventListener('DOMContentLoaded', function () {
    var inputField = document.querySelector('input[name="id"]');

    inputField.addEventListener('click', function () {
        var userId = this.value; 
		var url =  '/note/send?userId=' + userId;
        // 팝업 창 열기
        var popupOptions = 'width=500,height=500,scrollbars=yes,resizable=yes';
        var popupWindow = window.open(url, 'note', popupOptions);
    });
});