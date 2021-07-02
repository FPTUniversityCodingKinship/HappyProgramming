/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var skillsList;
var numSkill = parseInt($("#numSkills").val(), 10);
var _numSkill = parseInt($("#numSkills").val(), 10);

function removeSkill(skillId) {
    var selector = "div[id='skill" + skillId + "']";
    $(selector).remove();
    numSkill--;
}

function displayError(id, name, min, max) {
    var selector = ".error[id='err" + id + "']";
    var htmlStr = name + ' requires input from ' + min + ' to ' + max + ((name.includes("years") || name.includes("rate")) ? '' : ' characters!!');
    $(selector).removeClass("d-none").html(htmlStr);
}

/*
 // Check Email
 function validateEmail(email) {
 var emailReg = /^[a-zA-Z][a-zA-Z0-9\_\.\-]{4,31}@[a-z0-9]{2,}(\.[a-z0-9]{2,4}){1,2}$/g;
 //    var emailReg = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;
 return emailReg.test(email);
 }
 * 
 */

// Check Facebook URL
function validateFbURL(url) {
    var facebookReg = /^((http|https):\/\/|)(www\.|)facebook\.com\/[a-zA-Z0-9.=?\/]{1,}$/g;
    var check = facebookReg.test(url);
    return check;
}

// Check Github URL
function validateGithubURL(url) {
    var githubReg = /^((http|https):\/\/|)(www\.|)github\.com\/[a-zA-Z0-9.]{1,}$/g;
    return githubReg.test(url);
}


document.addEventListener("DOMContentLoaded", function () {

    tinymce.init({
        selector: '.editor'
    });


// Get skills

    $.ajax({
        type: 'GET',
        url: 'GetSkillsList',
        async: false,
        data: '',
        success: function (data) {
            skillsList = data;
//            console.log(skillsList);
        },
        error: function (data) {
//            console.log(data);
        }
    });

    $("#imageFile").change(function() {
        
        if(this.files[0].size > 2097152){
           $("#errAvatar").removeClass("d-none").html("File is too large! Only file whose size is less than 2MB is allowed.");
           this.value = "";
        } else {
            $("#errAvatar").addClass("d-none").html("");
        }
    });

    // Fill DropDown
//    $.each(skillsList, function (i, skill) {
//        $('select[data-filled="skillsList"]').append($('<option/>').attr("value", skill.skillID).text(skill.skillName));
////        console.log(skill.skillID + ": " + skill.skillName);
//    });

    $("#btnAddSkill").click(function () {
        var idDivSkill = "skill0";
        var selector = "#" + idDivSkill;
        var nextNumSkill = _numSkill + 1;
        var nextIdDivSkill = "skill" + nextNumSkill;

//        console.log(selector);
//        console.log(nextIdDivSkill);
        $(selector).clone().insertBefore("#btnAddSkill").attr("id", nextIdDivSkill);

        selector = "#" + nextIdDivSkill;
        $(selector).last().removeClass("d-none");

//        numSkill++;
//        console.log(numSkill);
        $("#numSkills").val(nextNumSkill);

        var nextYearId = "years" + nextNumSkill;
        var nextRateId = "rate" + nextNumSkill;
        var nextErrorYearsId = "errSkillYears" + nextNumSkill;
        var nextErrorRateId = "errSkillRate" + nextNumSkill;
        var nextBtnId = "btnRemoveSkill" + nextNumSkill;

        selector = "select[name='skill" + 0 + "']";
        $(selector).last().attr("name", nextIdDivSkill);

        selector = "label[for='years" + 0 + "']";
        $(selector).last().attr("for", nextYearId);

        selector = "input[name='years" + 0 + "']";
        $(selector).last().attr("name", nextYearId);

        selector = "input[id='years" + 0 + "']";
        $(selector).last().attr("id", nextYearId);

        selector = "label[for='rate" + 0 + "']";
        $(selector).last().attr("for", nextRateId);

        selector = "input[name='rate" + 0 + "']";
        $(selector).last().attr("name", nextRateId);

        selector = "input[id='rate" + 0 + "']";
        $(selector).last().attr("id", nextRateId);

        selector = "input[id='btnRemoveSkill" + 0 + "']";
        $(selector).last().attr("id", nextBtnId);
        selector = "input[id='btnRemoveSkill" + nextNumSkill + "']";
        var event = "removeSkill(" + nextNumSkill + ")";
        if (_numSkill === 0) {
            $(selector).last().attr("onclick", event);

        } else {
            $(selector).last().css("display", "inline").attr("onclick", event);
        }

        selector = "div[id='errSkillYears" + 0 + "']";
        $(selector).last().attr("id", nextErrorYearsId);

        selector = "div[id='errSkillRate" + 0 + "']";
        $(selector).last().attr("id", nextErrorRateId);

        _numSkill = nextNumSkill;
        numSkill++;

    });


    $("#btnUpdate").click(function () {

        // Clear all Error before
        $(".error").html("");

        // Get Parameter
        var userID = $("input[name='userID']").val();
        var image = $("#imageFile").val();
        var fullname = $("#fullname").val();
        var dobInput = $("#dob").val();

//        var email = $("#email").val();
        var sex = $("#sex").val();
        var address = $("#address").val();
        var facebook = $("#facebook").val();
        var github = $("#github").val();
        var language = $("#language").val();
        var profession = $("#profession").val();
//        var proDescription = $("#proDescription").val();
        var proDescription = tinymce.get("proDescription").getContent();
//        var serDescription = $("#serDescription").val();
        var serDescription = tinymce.get("serDescription").getContent();
//        var achDescription = $("#achDescription").val();
        var achDescription = tinymce.get("achDescription").getContent();


// Get Skills List
        var skillsList = new Array();
        var numSkills = $("#numSkills").val();
        var selector = "";
        for (var i = 1; i <= numSkills; i++) {
            selector = "select[name='skill" + i + "']";
            var skillID = $(selector).val();

            selector = "#years" + i;
            var skillYear = $(selector).val();

            selector = "#rate" + i;
            var skillRate = $(selector).val();

            skillsList.push({
                num: i,
                skillID: skillID,
                yearsExperience: skillYear,
                rate: skillRate
            });
        }
//        console.log(JSON.stringify(skillsList));
//        console.log(skillsList);
        var isError = false;

        if (fullname.length > 50 || fullname.length < 2) {
            displayError("Fullname", "Full Name", 2, 50);
            isError = true;
        }

        // Validate Date of birth
        var dob, dobDate;
        if (!dobInput || dobInput.length === 0) {
            isError = true;
            $(".error[id=errDob]").removeClass("d-none").html("Date of birth is in a wrong format! Correct format is dd/mm/yyyy");
        } else {

            dobDate = new Date(dobInput);
            var month = dobDate.getMonth() + 1;
            dob = dobDate.getDate() + "/" + month + "/" + dobDate.getFullYear();
        }

//        if (!validateEmail(email)) {
//            $(".error[id='errEmail']").html('<font color="red">Please enter a valid Email!!!</font>');
//            isError = true;
//        }
        if (address.length > 255 || address.length < 5) {
            displayError("Address", "Address", 5, 255);
            isError = true;
        }
        if (!validateFbURL(facebook)) {
            $(".error[id='errFacebook']").removeClass("d-none").html('Please enter a valid Facebook Profile URL!!!');
            isError = true;
        }
        if (!validateGithubURL(github)) {
            $(".error[id='errGithub']").removeClass("d-none").html('Please enter a valid Github Profile URL!!!');
            isError = true;
        }
        if (language.length > 255 || language.length < 2) {
            displayError("Language", "Language", 2, 255);
            isError = true;
        }
        if (profession.length > 100 || profession.length < 5) {
            displayError("Profession", "Profession", 5, 100);
            isError = true;

        }
        if (proDescription.length > 500 || proDescription.length < 5) {
            displayError("ProDescription", "Profession Description", 5, 500);
            isError = true;

        }
        if (serDescription.length > 500 || serDescription.length < 5) {
            displayError("SerDescription", "Service Description", 5, 500);
            isError = true;

        }
        if (achDescription.length > 500 || achDescription.length < 5) {
            displayError("AchDescription", "Achievement Description", 2, 50);
            isError = true;
        }
        skillsList.forEach(function (skill) {
            if (skill.yearsExperience < 0 || skill.yearsExperience > 50) {
                var selector = "SkillYears" + skill.num;
                displayError(selector, "Skill's years of experience", 1, 50);
                isError = true;
            }
            if (skill.rate < 1 || skill.rate > 5) {
                var selector = "SkillRate" + skill.num;
                displayError(selector, "Skill's rate", 1, 5);
                isError = true;
            }
        });

        if (!isError) {
            var form = $('#updateInformation');
            form.submit();
//            form.submit();
        } else {
            var scrollTo = $('.error').not('.d-none').first();
            $('html, body').animate({
                scrollTop: scrollTo.offset().top
            }, 1000);
        }
    });

});