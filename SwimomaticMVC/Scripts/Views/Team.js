$(document).ready(function () {
    $("#Roster").hide();

    //mutually exclusive checkbox for TeamLeagueRequest
    $("input[class^='chkSeason']").click(function () {
        var seasonID = this.id.substring(9);
        var chkId = this.id;
        $(".chkSeason" + seasonID).each(function (index) {
            if ($(this).attr('id') != chkId) {
                $(this).attr('checked', false);
            }
        });
    });

    $("input[class='chkHomePoolConfig']").click(function () {
        var homePoolConfigID = this.id.substring(19);
        if ($(this).is(':checked')) {
            $("#HomePoolConfigID").val(homePoolConfigID);
        }
    });

    $("#PoolSearch").dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        draggable: true,
        height: 750,
        width: 600,
        buttons: {
            //            'OK': function (event, ui) {
            //                SaveHomePoolConfig();
            //                $(this).dialog('close');
            //            },
            Cancel: function (event, ui) {
                $(this).dialog('close');
            }
        }
    });

    $("#lnkChangeHomePool").live('click', function () {
        $("#PoolSearch").dialog("open");

        //Initialize Pool Search Map
        //if this is a new pool, initialize the map with the user's home city, State
        var address = '';
        var homePoolConfigID = $("#hdnHomePoolConfigID").val();

        if (homePoolConfigID > 0) {
            address = $("#hdnHomePoolConfigCity").val() + ',' + $("#hdnHomePoolConfigRegionAbbrev").val();
        }
        else {
            address = $("#hdnCityState").val();
        }
        InitializeMap(address);
    });
});

function ShowTeam(UserTeamID) {
    LoadTag('#Team', '/Team/Team?UserTeamID=' + UserTeamID);
    $("#Team").show();
}
function ShowTeamSeasons(TeamID) {
    LoadTag('#TeamSeasons', '/Team/TeamSeasons?TeamID=' + TeamID);
    $("#TeamSeasons").show();
    $('#LeagueSearch').hide();
    $("#Team").hide();
    $("#Roster").hide();
}
function ShowRoster(TeamSeasonID) {
    ShowSwimmers(TeamSeasonID);
    ShowRequests(TeamSeasonID);
    $("#Roster").show();
}
function ShowLeagueSearch(UserTeamID) {
    LoadTag('#LeagueSearch', '/Team/LeagueSearch?UserTeamID=' + UserTeamID);
    $('#LeagueSearch').show();
    $('#TeamLeagueRequest').hide();
    $("#TeamSeasons").hide();
    $("#Team").hide();
    $("#Roster").hide();
}
function ShowSwimmers(TeamSeasonID) {
    LoadTag('#SwimmerTeamSeasons', '/Team/SwimmerTeamSeasons?TeamSeasonID=' + TeamSeasonID);
}
function ShowRequests(TeamSeasonID) {
    LoadTag('#SwimmerTeamRequests', '/Team/SwimmerTeamRequests?TeamSeasonID=' + TeamSeasonID);
}
function SaveTeamSuccess() {
    $("#Team").hide();
}
function ApproveRequest(SwimmerTeamRequestID, TeamSeasonID) {
    LoadTag('#SwimmerTeamSeasons', '/Team/ApproveRequest?SwimmerTeamRequestID=' + SwimmerTeamRequestID + '&TeamSeasonID=' + TeamSeasonID);
    ShowRequests(TeamSeasonID);
}
function SaveSwimmerTeamRequest(UserSwimmerID) {
    var teamSeasonID = $("input[id^='chkTeamSeason']:checked:first").attr('id').substring(13);
    LoadTag('#Swimmer', '/Swimmer/SaveSwimmerTeamRequest?TeamSeasonID=' + teamSeasonID + '&UserSwimmerID=' + UserSwimmerID);
}

function SaveTeamLeagueRequest(UserTeamID) {
    var seasonID = $("input[id^='chkSeason']:checked:first").attr('id').substring(9);
    LoadTag('#TeamLeagueRequest', '/Team/SaveTeamLeagueRequest?SeasonID=' + seasonID + '&UserTeamID=' + UserTeamID);
}
function LeagueSearchSuccess() {
    $("#LeagueSearch").hide();
    $("#TeamLeagueRequest").show();
}

function HideTeamSeasonRequest() {
    $("#TeamLeagueRequest").hide();
}