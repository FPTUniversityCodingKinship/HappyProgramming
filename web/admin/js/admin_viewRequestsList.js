/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function checkPending() {
    if ($("#pending").is(":checked")) {

        $("#startDate").attr("disabled", "disabled");
        $("#endDate").attr("disabled", "disabled");
    } else {
        $("#startDate").removeAttr("disabled");
        $("#endDate").removeAttr("disabled");
    }
}

document.addEventListener("DOMContentLoaded", function () {
    checkPending();

    $("#pending").click(function () {

        checkPending();
    });
});