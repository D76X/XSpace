// function showAlert() { window.alert("This is an alert!"); }
// function changeStyle() { document.getElementById("header1").style.color = "red"; }

// https://www.tutorialsteacher.com/jquery/jquery-load-method
$('#article1').load('/article1.html');
$('#article2').load('/article2.html #title');
$('#msgDiv').load('/demo.html #myHtmlContent');

// https://www.w3schools.com/jquery/ajax_getjson.asp
// https://stackoverflow.com/questions/28149462/how-to-print-json-data-in-console-log
// https://stackoverflow.com/questions/45332131/call-azure-function-from-javascript
// https://markheath.net/post/enable-cors-local-test-azure-functions
$.getJSON("http://localhost:7071/api/GetMetadata", function (result) {
    console.dir(result);
});