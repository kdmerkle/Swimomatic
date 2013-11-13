$(document).ready(function () {
    $("#Teams").hide();

    $("#AgeClassRuleID").live("change", function () {
        if ($(this).val() == '1') {
            $("#customDate").show();
        }
        else {
            $("#customDate").hide();
        }
    });

    $("#btnSeasonCancel").live("click", function () {
        $("#Season").hide();
    });

    $("#btnLeagueCancel").live("click", function () {
        $("#League").hide();
    });

});


function ShowLeague(LeagueID) {
    LoadTag('#League', '/League/League?LeagueID=' + LeagueID);
    $("#League").show();
}
function SaveLeagueSuccess() {
    LoadTag('#Leagues', '/League/Leagues?');
}

function ShowSeasons(LeagueID) {
    LoadTag('#Seasons', '/League/Seasons?LeagueID=' + LeagueID);
    $("#Seasons").show();
    $("#Teams").hide();
}
function ShowTeams(SeasonID) {
    ShowTeamSeasons(SeasonID);
    ShowRequests(SeasonID);
    $("#Teams").show();
    $("#Season").hide();
}
function ShowTeamSeasons(SeasonID) {
    LoadTag('#TeamSeasons', '/League/TeamSeasons?SeasonID=' + SeasonID);
    $("#TeamSeasons").show();
}
function ShowSeason(LeagueID, SeasonID) {
    LoadTag('#Season', '/League/Season?SeasonID=' + SeasonID + '&LeagueID=' + escape(LeagueID));
    $("#Season").show();
    $("#Teams").hide();
}

function SaveSeasonSuccess() {
    var leagueID = $("#LeagueID").val();
    LoadTag('#Seasons', '/League/Seasons?LeagueID=' + leagueID);
}
function ShowRequests(SeasonID) {
    LoadTag('#TeamLeagueRequests', '/League/TeamLeagueRequests?SeasonID=' + SeasonID);
}
function ApproveRequest(TeamLeagueRequestID, SeasonID) {
    LoadTagWithCallback('#TeamLeagueRequests', '/League/ApproveRequest?TeamLeagueRequestID=' + TeamLeagueRequestID + '&SeasonID=' + SeasonID, ShowTeamSeasons(SeasonID));
}