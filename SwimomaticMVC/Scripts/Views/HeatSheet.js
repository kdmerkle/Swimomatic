$(document).ready(function () {

    $(".heats").hide();
    $(".edithse").hide();
    $("#availableswimmers").dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        draggable: true,
        height: 240,
        buttons: {
            'OK': function (event, ui) {
                AddHeatSwimmer();
                $(this).dialog('close');
            },
            Cancel: function (event, ui) {
                $(this).dialog('close');
            }
        }
    });

    $(".AddHeatSheetEvent").live("click", function () {
        var id = $(this).attr("id");
        ShowHeatSheetEvent(id);
    });
    $(".ShowHideHeatSheetEvent").live("click", function () {
        var id = $(this).attr("id");
        ShowHideHeatSheetEvent(id);
    });
    $(".ShowEligibleSwimmers").live("click", function () {
        var id = $(this).attr("id");
        ShowEligibleSwimmers(id);
    });
    $(".DeleteHeatSheetEvent").live("click", function () {
        var id = $(this).attr("id").split(',');
        DeleteHeatSheetEvent(id[0], id[1]);
    });
    $(".AddHeat").live("click", function () {
        var id = $(this).attr("id");
        AddHeat(id);
    });
    $(".AddSwimmer").live("click", function () {
        var id = $(this).attr("id");
        ShowAvailableSwimmers(id);
    });
    $(".DeleteHeat").live("click", function () {
        var id = $(this).attr("id").split(',');
        DeleteHeat(id[0],id[1]);
    });
    $(".IncrementLane").live("click", function () {
        var id = $(this).attr("id").split(',');
        IncrementLane(id[0],id[1],id[2],id[3]);
    });
    $(".DecrementLane").live("click", function () {
        var id = $(this).attr("id").split(',');
        DecrementLane(id[0],id[1],id[2],id[3]);
    });
    $(".IncrementLeg").live("click", function () {
        var id = $(this).attr("id").split(',');
        IncrementLeg(id[0],id[1],id[2]);
    });
    $(".DecrementLeg").live("click", function () {
        var id = $(this).attr("id").split(',');
        DecrementLeg(id[0],id[1],id[2]);
    });
    $(".RemoveHeatSwimmer").live("click", function () {
        var id = $(this).attr("id").split(',');
        RemoveHeatSwimmer(id[0],id[1],id[2]);
    });

    $("#ShowHeatSheetEvents").live("click", function () {
        var heatSheetID = $(this).attr("class");
        ShowHeatSheetEvents(heatSheetID);
    });

    $("#ShowHeatSheetEventsByUser").live("click", function () {
        var heatSheetID = $(this).attr("class");
        ShowHeatSheetEventsByUser(heatSheetID);
    });

    $(".PrintTimerSheet").live("click", function () {
        var heatSheetEventID = $(this).attr("rel");
        PrintTimerSheet(heatSheetEventID);
    });

    //InitSortable();

    //ensures only one team can pick a lane on HeatSheetTeams
    $("input[class^='chkLane']").click(function () {
        var pos = this.id.indexOf("_");
        var laneNum = this.id.substring(3, pos);
        var chkId = this.id;
        $(".chkLane" + laneNum).each(function (index) {
            if ($(this).attr('id') != chkId) {
                $(this).attr('checked', false);
            }
        });
    });
});

function InitSortable() {
    $("#sortable").sortable({ stop: function (event, ui) { ResequenceHeatSheetEvents(event, ui); } });
    $("#sortable").disableSelection();
}
function ResequenceHeatSheetEvents(event, ui) {
    var result = $("#sortable").sortable('toArray');
    var heatSheetEventIDs = new Array();
    var heatSheetID = $("#sortableheatsheetid").val();
    var index = 0;
    for (var i = 0; i < result.length; i++) {
        if (!isNaN(result[i])) {
            heatSheetEventIDs[index] = result[i] + '';
            index++;
        }
    }
    var heatSheetEventSequence = {
        HeatSheetID: heatSheetID,
        HeatSheetEventIDs: heatSheetEventIDs
    };

    $.ajax({
        url: "/HeatSheet/ResequenceHeatSheetEvents",
        type: "POST",
        data: JSON.stringify(heatSheetEventSequence),
        dataType: "json",
        contentType: "application/json; charset=utf-8"
    });
    ShowHeatSheetEvents(heatSheetID);
}
function DeleteHeatSheetEvent(HeatSheetEventID, HeatSheetID) {
    LoadTagWithCallback('#HeatSheetEvents', '/HeatSheet/DeleteHeatSheetEvent?HeatSheetEventID=' + HeatSheetEventID + '&HeatSheetID=' + HeatSheetID, ReInitHeatSheetEvents);
}
function ReInitHeatSheetEvents() {
    $(".heats").hide();
    $(".edithse").hide();
    InitSortable();
}
function ShowHideHeatSheetEvent(HeatSheetEventID) {
    var elem = $("#heats" + HeatSheetEventID)[0];
    if (elem.style.display == 'none') {
        $('#editHeatSheetEvent' + HeatSheetEventID).show();
        $('#heats' + HeatSheetEventID).show();
    }
    else {
        $('#editHeatSheetEvent' + HeatSheetEventID).hide();
        $('#heats' + HeatSheetEventID).hide();
    }
}

function ShowHeatSheetEvent(HeatSheetID) {
    LoadTag('#HeatSheetEvent', '/HeatSheet/HeatSheetEvent?HeatSheetID=' + HeatSheetID);
    $('#HeatSheetEvent').show();
}

function ShowHeatSheetEvents(HeatSheetID) {
    LoadTagWithCallback('#HeatSheetEvents', '/HeatSheet/HeatSheetEvents?HeatSheetID=' + HeatSheetID, ReInitHeatSheetEvents);
    $('#HeatSheetEvents').show();
    $('#HeatSheetList').hide();
}

function ShowHeatSheetEventsByUser(HeatSheetID) {
    LoadTagWithCallback('#HeatSheetEvents', '/HeatSheet/HeatSheetEventsByUser?HeatSheetID=' + HeatSheetID, ReInitHeatSheetEvents);
    $('#HeatSheetEvents').show();
    $('#HeatSheetList').hide();
}

function ShowAvailableSwimmers(HeatID) {
    LoadTag('#availableswimmers', '/HeatSheet/GetAvailableSwimmers?HeatID=' + HeatID);
    $("#availableswimmers").dialog("open");
}

function AddHeatSwimmer() {
    var heatID = $("#addswimmer_HeatID").val();
    var swimmerTeamSeasonID = $("#addswimmer_SwimmerTeamSeasonID").val();
    var leg = 0;

    //check for existence of Leg, Lane Number
    if ($("#addswimmer_Leg").length !== 0) {
        leg = $("#addswimmer_Leg").val();
    }

    var laneNumber = 0;
    if ($("#addswimmer_LaneNumber").length !== 0) {
        laneNumber = $("#addswimmer_LaneNumber").val();
    }
    var HeatSheetEventID = $("#addswimmer_HeatSheetEventID").val();
    LoadTag('#heats' + HeatSheetEventID, '/HeatSheet/AddHeatSwimmer?HeatID=' + heatID + '&SwimmerTeamSeasonID=' + swimmerTeamSeasonID + '&Leg=' + leg + '&LaneNumber=' + laneNumber);
    RefreshAvailableSwimmers(heatID)
}
function RemoveHeatSwimmer(HeatID, HeatSwimmerID, HeatSheetEventID) {
    LoadTag('#heats' + HeatSheetEventID, '/HeatSheet/RemoveHeatSwimmer?HeatSwimmerID=' + HeatSwimmerID);
    RefreshAvailableSwimmers(HeatID)
}
function RefreshAvailableSwimmers(HeatID) {
    LoadTag('#availableswimmers', '/HeatSheet/GetAvailableSwimmers?HeatID=' + HeatID);
}

function AddHeat(HeatSheetEventID) {
    LoadTag('#heats' + HeatSheetEventID, '/HeatSheet/AddHeat?HeatSheetEventID=' + HeatSheetEventID);
}
function DeleteHeat(HeatID, HeatSheetEventID) {
    LoadTag('#heats' + HeatSheetEventID, '/HeatSheet/DeleteHeat?HeatID=' + HeatID + '&HeatSheetEventID=' + HeatSheetEventID);
}
function IncrementLane(HeatID, HeatSwimmerID, HeatSheetEventID, isRelay) {
    LoadTag('#heats' + HeatSheetEventID, '/HeatSheet/IncrementLane?HeatID=' + HeatID + '&HeatSwimmerID=' + HeatSwimmerID + '&Move=1' + '&IsRelay=' + isRelay);
}
function DecrementLane(HeatID, HeatSwimmerID, HeatSheetEventID, isRelay) {
    LoadTag('#heats' + HeatSheetEventID, '/HeatSheet/IncrementLane?HeatID=' + HeatID + '&HeatSwimmerID=' + HeatSwimmerID + '&Move=' + escape("-") + '1' + '&IsRelay=' + isRelay);
}
function IncrementLeg(HeatID, HeatSwimmerID, HeatSheetEventID) {
    LoadTag('#heats' + HeatSheetEventID, '/HeatSheet/IncrementLeg?HeatID=' + HeatID + '&HeatSwimmerID=' + HeatSwimmerID + '&Move=1');
}
function DecrementLeg(HeatID, HeatSwimmerID, HeatSheetEventID) {
    LoadTag('#heats' + HeatSheetEventID, '/HeatSheet/IncrementLeg?HeatID=' + HeatID + '&HeatSwimmerID=' + HeatSwimmerID + '&Move=' + escape("-") + '1');
}
function AddHeatSheet(SwimMeetID) {
    LoadTag('#PoolConfigs', '/HeatSheet/PoolConfigs?SwimMeetID=' + SwimMeetID);
}

function ShowHeatSheetTeams(SwimMeetID) {
    var poolConfigID = $("input[id^='chkPoolConfig']:checked:first").attr('id').substring(13);
    LoadTag('#HeatSheetTeams', '/HeatSheet/HeatSheetTeams?PoolConfigID=' + poolConfigID + '&SwimMeetID=' + SwimMeetID);
}

function SaveHeatSheet(swimMeetID) {
    var heatSheet = {
        SwimMeetID: swimMeetID + '',
        PoolConfigID: $("input[id^='chkPoolConfig']:checked:first").attr('id').substring(13),
        HeatSheetTeams: GetHeatSheetTeams(swimMeetID)
    };

    $.ajax({
        url: "/HeatSheet/SaveHeatSheet",
        type: "POST",
        data: JSON.stringify(heatSheet),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            LoadTag('#HeatSheetList', '/HeatSheet/HeatSheets?SwimMeetID=' + swimMeetID);
        }
    });

    $("#HeatSheetTeams").hide();
    $("#PoolConfigs").hide();
    $("#HeatSheetList").show();
}

function GetHeatSheetTeams(SwimMeetID) {
    //save each checked TeamSeason-LaneNumber checkbox into an array
    var teamId = 0;
    var laneNum = 0;
    var pos = 0;
    var arrTeamLanes = new Array();
    $("input[class^='chkLane']:checked").each(function (index) {
        pos = $(this).attr('id').indexOf("_");
        laneNum = $(this).attr('id').substring(3, pos);
        teamSeasonId = $(this).attr('id').substring(pos + 1);
        oTL = new Object();
        oTL.TeamSeasonID = teamSeasonId;
        oTL.LaneNumber = laneNum;
        arrTeamLanes[index] = oTL;
    });
    return arrTeamLanes;
}

function HideHeatSheetEvent() {
    $("#HeatSheetEvent").hide();
}
function SaveHeatSheetEventSuccess() {
    HideHeatSheetEvent();
    ReInitHeatSheetEvents();
    $("#EligibleSwimmers").show();
}
function SeedHeatSheetEventSuccess() {
    HideEligibleSwimmers();
    ReInitHeatSheetEvents();
}
function ShowEligibleSwimmers(HeatSheetEventID) {
    LoadTag('#EligibleSwimmers', '/HeatSheet/GetEligibleSwimmers?HeatSheetEventID=' + HeatSheetEventID);
    $("#EligibleSwimmers").show();
}
function HideEligibleSwimmers() {
    $("#EligibleSwimmers").hide();
}

function PrintTimerSheet(heatSheetEventID) {
    window.open('/Report/LaneTimerSheetByHeatSheetEvent?HeatSheetEventID=' + heatSheetEventID, '_blank', '', '');
}