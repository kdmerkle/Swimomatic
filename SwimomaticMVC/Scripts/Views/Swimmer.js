$(document).ready(function () {
    $("#btnSwimmerCancel").click(function (event) { $("#Swimmer").hide(); });

    //mutually exclusive checkbox for SwimmerTeamRequest
    $(".chkTeamSeason").click(function (event) {
        var teamSeasonID = this.id.substring(10);
        var chkId = this.id;
        $(".chkTeamSeason").each(function (index) {
            if ($(this).attr('id') != chkId) {
                $(this).attr('checked', false);
            }
        });
    });
});

function ShowSwimmer(UserSwimmerID) {
    LoadTag('#Swimmer', '/Swimmer/Swimmer?UserSwimmerID=' + UserSwimmerID);
    $("#Swimmer").show();
}
function SaveSwimmerSuccess() {
    $("#Swimmer").hide();
}
function HideSwimmerTeamRequest() {
    $("#SwimmerTeamRequest").hide();
}
function TeamSearchSuccess() {
    $("#TeamSearch").hide();
}
function SaveSwimmerTeamRequest(UserSwimmerID) {
    var ckbx = $("input[id^='TeamSeason']:checked:first");
    var strID = ckbx.attr('id');
    var teamSeasonID = strID.substring(10);
    LoadTag('#SwimmerTeamRequest', '/Swimmer/SaveSwimmerTeamRequest?TeamSeasonID=' + teamSeasonID + '&UserSwimmerID=' + UserSwimmerID);
}

function ShowTeamSearch(UserSwimmerID) {
    LoadTag("#TeamSearch", '/Swimmer/TeamSearch?UserSwimmerID=' + UserSwimmerID);
    $('#TeamSearch').show();
    $("#Swimmer").hide();
}
