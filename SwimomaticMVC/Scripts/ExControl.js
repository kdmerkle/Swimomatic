function LoadTag(tagname, actionUrl) {
    $(tagname).load(actionUrl + GetRandom(), function (html) {
        $(tagname)[0].value = html;
    });
}

function LoadTagWithCallback(tagname, actionUrl, callback) {
    $(tagname).load(actionUrl, callback);
}

// jQuery JSON Ajax wrapper.
function CallJsonAjax(params, url, success, error) {
    $.ajax({
        dataType: "json",
        type: "post",
        data: params,
        url: url,
        success: success,
        cache: false,
        error: error
    });
}

function GetRandom() {
    return "&rand=" + Math.floor(Math.random() * 100000);
}

function ShowHide(divNameShow, divNameHide) {
    $("#" + divNameHide).hide();
    $("#" + divNameShow).show();
}

function htmlEncode(value) {
    return $('<div/>').text(value).html();
}

function htmlDecode(value) {
    return $('<div/>').html(value).text();
}

function globalAjaxCursorChange() {
    //    $("html").bind("ajaxStart", function () {
    //        $(this).addClass('busy');
    //    }).bind("ajaxStop", function () {
    //        $(this).removeClass('busy');
    //    });
}

