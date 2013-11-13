$(document).ready(function () {
    $('body').delegate('#RegionSearch', 'change', function () {
        var region = $("#RegionSearch").val();
        CallJsonAjax(null, "/SwimMeet/GetCities?RegionID=" + region, CitySearchCallback, AjaxError);
    });

    //Bind events to clear/fill dropdown lists
    $.fn.clearSelect = function () {
        return this.each(function () {
            if (this.tagName == 'SELECT')
                this.options.length = 0;
        });
    }

    $.fn.fillSelect = function (data) {
        return this.clearSelect().each(function () {
            if (this.tagName == 'SELECT') {
                var dropdownList = this;
                $.each(data, function (index, optionData) {
                    var option = new Option(optionData.Text, optionData.Value);

                    if ($.browser.msie) {
                        dropdownList.add(option);
                    }
                    else {
                        dropdownList.add(option, null);
                    }
                });
            }
        });
    }
});

function CitySearchCallback(event, ui) {
    $("#CitySearch").fillSelect(event);
}

function AjaxError(data) {
    alert(data.responseText);
}
