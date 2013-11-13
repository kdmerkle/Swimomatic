$(document).ready(function () {

    //set hidden ET value = txtET
    $("input[id^='txtET']").change(function () {
        var heatSwimmerID = $(this).attr('id').substring(5);
        var elapsedTime = $(this).val();
        $("input[class^='clsET" + heatSwimmerID + "']").each(function () {
            $(this).val(elapsedTime);
        });
    });

    //set chkDQ value = 0 when unchecked, 1 when checked
    $("input[id^='chkDQ']").click(function () {
        var heatSwimmerID = $(this).attr('id').substring(5);
        var dq = $(this).is(':checked') ? 'true' : 'false';
        $("input[class^='clsDQ" + heatSwimmerID + "']").each(function () {
            $(this).val(dq);
        });
    });

    $(".ElapsedTime").blur(function () {
        var filter = /^((([0-5]?[0-9]{1}:?)?[0-5]{1})?([0-9]{1}[.]?[0-9]{2}))$/;
        if (!filter.test($(this).val())) {
            alert('Use mm:ss.00 format.\n2 decimal places are required.\nColon and decimal point are not required.');
        }
        else {
            var str = $(this).val();

            //add decimal point
            if (str.charAt(str.length - 3) != '.') {
                str = str.substr(0, str.length - 2) + '.' + str.substr(str.length - 2);
            }

            //if length > 5, minutes were entered so add 1st colon
            if (str.length > 5 && str.indexOf(':') < 0) {
                str = str.substr(0, str.length - 5) + ':' + str.substr(str.length - 5);
            }

            ////if length > 8, hours were entered so add 2nd colon
            //if(str.length > 8){
            //	str = str.substr(0, str.length-8) + ':' + str.substr(str.length-8);
            //}
            //alert(str);	

            //set text input = formatted value			
            $(this).val(str);

            //set hidden input = formatted value			
            var heatSwimmerID = $(this).attr('id').substring(5);
            $("input[class^='clsET" + heatSwimmerID + "']").each(function () {
                $(this).val(str);
            });

        }
    });
});

function SaveHeatSheetEventResultsSuccess() {
    $("#HeatSheetEventResults").hide();
}
