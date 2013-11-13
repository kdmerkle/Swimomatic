function LocationSearch() {
    var regionID = $("#RegionSearch").val();
    var city = $("#CitySearch").val();
    LoadTag('#locationList', '/Location/LocationSearch?RegionID=' + regionID + '&City=' + escape(city) + '&Merge=0');
}
function ShowLocation(LocationID) {
    LoadTag('#location', '/Location/Location?LocationID=' + LocationID);
}
function SaveLocationSuccess() {
    $("#location").hide();
}
function SavePoolSuccess() {
    $("#Pool").hide();
}
function SavePoolConfigSuccess() {
    $("#PoolConfig").hide();
}
function ShowPoolConfig(PoolID, PoolConfigID) {
    LoadTag('#PoolConfig', '/Location/PoolConfig?PoolConfigID=' + PoolConfigID + '&PoolID=' + PoolID);
    $('#PoolConfig').show();
}
function ShowPool(PoolID, LocationID) {
    LoadTag('#Pool', '/Location/Pool?PoolID=' + PoolID + '&LocationID=' + LocationID);
    $('#Pool').show();
}
function SetUOMMinor() {
    var uomID = $("#UOMID").val();
    var minor = '';
    var major = '';
    if (uomID == 1) {
        major = 'Meters';
        minor = 'Centimeters';
    }
    else {
        major = 'Yards';
        minor = 'Inches';
    }
    $("#majorUOM").text(major);
    $("#minorUOM").text(minor);
}
