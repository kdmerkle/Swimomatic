$(document).ready(function () {
    //Initialize Date Pickers
    $("#StartDate").datepicker({
        changeMonth: true,
        changeYear: true,
        onClose: function (dateText, inst) {
            $("#EndDate").val($("#StartDate").val());
        }
    });

    $("#EndDate").datepicker({
        changeMonth: true,
        changeYear: true
    });

    //Initially Hide Create Swim Meet Wizard Divs
    $("#swimMeet").hide();
    $("#locationSearch").hide();
    $("#leagues").hide();
    $("#seasons").hide();
    $("#teams").hide();
    $("#locations").hide();
    $("#submitSwimMeet").hide();

    //Save Swim Meet -
    $("#btnSave").click(function () {
        $("#swimMeets").show();
        $("#submitSwimMeet").hide();

        //JSON model binding with ajax post
        var teamSeasonIDs = new Array();
        $("input[id^='chkTeamSeason']:checked").each(function () {
            teamSeasonIDs.push($(this).attr('id').substring(13));
        });

        var swimMeet = {
            SwimMeetID: '0',
            StartDate: $("#StartDate").val(),
            EndDate: $("#EndDate").val(),
            Description: $("#Description").val(),
            SwimMeetTypeID: $("input[id^='radSwimMeetType']:checked:first").attr('id').substring(15),
            LocationID: $("input[id^='chkLocation']:checked:first").attr('id').substring(11),
            LeagueID: $("input[id^='chkLeague']:checked:first").attr('id').substring(9),
            SeasonID: $("input[id^='chkSeason']:checked:first").attr('id').substring(9),
            TeamSeasonIDs: teamSeasonIDs
        };

        $.ajax({
            url: "/SwimMeet/SaveSwimMeet",
            type: "POST",
            data: JSON.stringify(swimMeet),
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                ResetControls();
            }
        });
    });

    //Initialize Delete Swim Meet Confirm dialog
    $('#confirmDelete').dialog({
        autoOpen: false,
        resizable: false,
        draggable: false,
        dialogClass: 'black',
        modal: true,
        buttons: {
            'Delete': function () {
                DeleteSwimMeet();
                $(this).dialog('close');
            },
            Cancel: function () {
                $(this).dialog('close');
            }
        }
    });

    $("#btnDatesNext").click(function () {
        ShowHide('leagues', 'swimMeet');
        $("#sumStartDate").text($("#StartDate").val());
        $("#sumEndDate").text($("#EndDate").val());
        $("#sumDescription").text($("#Description").val());
    });

    $("#btnLeagueNext").click(function () {
        ShowHide('seasons', 'leagues');
        var sLeague = $("input[id^='chkLeague']:checked").closest("td").siblings('.leagueName').text();
        $("#sumLeague").text(sLeague);
    });

    $(".leagueCheckbox").change(function () {
        if ($(this).attr('checked')) {
            $(".leagueCheckbox").attr('disabled', 'true');
            $(this).removeAttr('disabled');
        }
        else {
            $(".leagueCheckbox").removeAttr('disabled');
        }
    });

    $("#btnLocationNext").click(function () {
        ShowHide('submitSwimMeet', 'locations');
        var sLocation = $("input[id^='chkLocation']:checked").closest("td").siblings('.locationName').text();
        $("#sumLocation").text(sLocation);
        $("#locationSearch").hide();
    });

    //disable all but the checked checkbox when checked on locations
    $(".locationCheckbox").change(function () {
        if ($(this).attr('checked')) {
            $(".locationCheckbox").attr('disabled', 'true');
            $(this).removeAttr('disabled');
        }
        else {
            $(".locationCheckbox").removeAttr('disabled');
        }
    });

    //Seasons: Populates the Summary with the Season name
    $("#btnSeasonNext").live('click', function () {
        ShowHide('teams', 'seasons');
        var sSeason = $("input[id^='chkSeason']:checked").closest("td").siblings('.seasonName').text();
        $("#sumSeason").text(sSeason);
    });

    //SwimMeet/Seasons: creat list of teams and popluate the summary
    $("#btnTeamNext").live('click', function () {
        ShowHide('locations', 'teams');
        var sTeam = "";
        $("input[id^='chkTeam']:checked").each(function (index, element) {
            sTeam = sTeam + $(element).closest("td").siblings('.teamName').text();
            sTeam = sTeam + ", ";
        });
        sTeam = sTeam.substring(0, sTeam.length - 2);
        $("#sumTeams").text(sTeam);
    });

});
function GetLocationsBySearch() {
    var regionID = $("#RegionSearch").val();
    var city = $("#CitySearch").val();
    LoadTag('#locationList', '/Location/LocationsBySearch?RegionID=' + regionID + '&City=' + encodeURI(city) + '&Merge=1');
}

function GetSeasons(leagueID) {
    LoadTag('#seasons', '/SwimMeet/GetSeasons?LeagueID=' + leagueID);
}

function GetTeams(seasonID) {
    LoadTag('#teams', '/SwimMeet/GetTeams?SeasonID=' + seasonID);
}

function AddSwimMeet() {
    $("#swimMeets").hide();
    $("#swimMeet").show();
}

function ResetControls() {
    $(':input').not(':button, :submit, :reset, :hidden').val('').removeAttr('checked').removeAttr('selected');
}

function ShowConfirm(confirmMessage, Id) {
    $("#confirmDelete").dialog('open');
}

function ShowConfirmDelete(swimMeetID) {
    $("#deleteSwimMeetID").val(swimMeetID);
    $("#confirmDelete").dialog('open');
}

function DeleteSwimMeet() {
    var swimMeetID = $("#deleteSwimMeetID").val();
    LoadTag('#swimMeets', '/SwimMeet/DeleteSwimMeet?SwimMeetID=' + swimMeetID);
}

