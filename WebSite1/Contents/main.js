$(document).ready(function () {
    $("#hamburger").bind("click", function (e) {    
        e.preventDefault();    
        $("#menu").toggleClass("menuShow")
    });
});