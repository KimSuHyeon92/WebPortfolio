/** 
 * 모든 페이지에 공통으로 사용되는 스크립트
 * */

/* jqGrid 화면 사이즈에 맞게 크기 조정 */
function gridResize(gridId){
	var gridParentWidth = $('#gbox_' + gridId).parent().width();
	$('#' + gridId).jqGrid('setGridWidth', gridParentWidth);
};

function postAjax(url,dataBody,func){
	
	$.ajax({
		url	: url,
		type: 'POST',
		data :dataBody,
		success : func,
		error : function (XMLHttpRequest, textStatus, errorThrown) {

			alert('에러 \n'+XMLHttpRequest);
			
		},
		beforeSend : function () {
			$("body").prepend(
				"<div class='tempProgressBar' style='width:100%;height:100%;background-color:black;opacity:0.4;z-index:10000;position:fixed;'>" +
					"<div style='width:100px;height:100px;position:absolute;left:50%;top:50%'>" +
						"<img src='resources/img_loading.gif'></img>" +
					"</div>" + 
				"</div>"
			);
		},
		complete : function() {
			$("body").find(".tempProgressBar").remove();
		}
	});
};

/*쿠키관련*/
function setCookie(cookieName, value, exdays){
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}
 
function deleteCookie(cookieName){
    var expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}
 
function getCookie(cookieName) {
    cookieName = cookieName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cookieName);
    var cookieValue = '';
    if(start != -1){
        start += cookieName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cookieValue = cookieData.substring(start, end);
    }
    return unescape(cookieValue);
}