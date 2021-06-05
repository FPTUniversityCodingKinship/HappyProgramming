/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var skillsList;
var numSkill = 1;
function displayError(id, name, min, max) {
    var selector = ".error[id='err" + id + "']";
    var htmlStr = '<font color="red">' + name + ' requires input from ' + min + ' to ' + max + ' characters!!</font>';
    $(selector).html(htmlStr);
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

    // Fill DropDown
    $.each(skillsList, function (i, skill) {
        $('select[data-filled="skillsList"]').append($('<option/>').attr("value", skill.skillID).text(skill.skillName));
//        console.log(skill.skillID + ": " + skill.skillName);
    });

    $("#btnAddSkill").click(function () {
        var idDivSkill = "skill" + numSkill;
        var selector = "#" + idDivSkill;
        var nextNumSkill = numSkill + 1;
        var nextIdDivSkill = "skill" + nextNumSkill;
//        console.log(selector);
//        console.log(nextIdDivSkill);
        $(selector).clone().insertAfter(selector).attr("id", nextIdDivSkill);
//        numSkill++;
//        console.log(numSkill);
        $("#numSkills").val(nextNumSkill);

        var nextYearId = "years" + nextNumSkill;
        var nextRateId = "rate" + nextNumSkill;

        selector = "select[name='skill" + numSkill + "']";
        $(selector).last().attr("name", nextIdDivSkill);

        selector = "label[for='years" + numSkill + "']";
        $(selector).last().attr("for", nextYearId);

        selector = "input[name='years" + numSkill + "']";
        $(selector).last().attr("name", nextYearId);

        selector = "input[id='years" + numSkill + "']";
        $(selector).last().attr("id", nextYearId);

        selector = "label[for='rate" + numSkill + "']";
        $(selector).last().attr("for", nextRateId);

        selector = "input[name='rate" + numSkill + "']";
        $(selector).last().attr("name", nextRateId);

        selector = "input[id='rate" + numSkill + "']";
        $(selector).last().attr("id", nextRateId);

        numSkill = nextNumSkill;

    });


    $("#btnCreate").click(function () {

        // Clear all Error before
        $(".error").html("");

        // Get Parameter
        var userID = $("input[name='userID']").val();
        var fullname = $("#fullname").val();
        var dobInput = $("#dob").val();
        var dobDate = new Date(dobInput);
        var dob = dobDate.getDate() + "/" + dobDate.getMonth() + "/" + dobDate.getFullYear();
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

//        if (!validateEmail(email)) {
//            $(".error[id='errEmail']").html('<font color="red">Please enter a valid Email!!!</font>');
//            isError = true;
//        }
        if (address.length > 255 || address.length < 5) {
            displayError("Address", "Address", 5, 255);
            isError = true;
        }
        if (!validateFbURL(facebook)) {
            $(".error[id='errFacebook']").html('<font color="red">Please enter a valid Facebook Profile URL!!!</font>');
            isError = true;
        }
        if (!validateGithubURL(github)) {
            $(".error[id='errGithub']").html('<font color="red">Please enter a valid Github Profile URL!!!</font>');
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

        if (!isError) {

            // AJAX to Servlet
            $.ajax({
                type: 'POST',
                url: 'CreateCV',
                data: {
                    'userID': userID,
                    'fullname': fullname,
                    'dob': dob,
                    'sex': sex,
                    'address': address,
                    'facebook': facebook,
                    'github': github,
                    'language': language,
                    'profession': profession,
                    'proDescription': proDescription,
                    'serDescription': serDescription,
                    'achDescription': achDescription
                },
                success: function (data) {
                    var strData = JSON.parse(data);
//                    console.log(strData);
//                    console.log(strData.success);
                    if (strData.success) {
                        
                        // AJAX to addSkills
                        $.ajax({
                            type: 'POST',
                            url: 'AddMentorSkills',
                            data: {
                                'skillsList': JSON.stringify(skillsList),
                                'mentorID': userID
                            },
                            success: function (data) {
                                var strData = JSON.parse(data);
//                                console.log(strData);
//                                console.log(strData.success);
                                if (strData.success) {
                                    $("#noti").html("Your CV has been created successfully!!");
                                } else {
                                    $("#noti").html(strData.message);
                                }
                            },
                            error: function (data) {
                                console.log(data);
                            }
                        });
                    } else {
                        $("#noti").html(strData.message);
                    }
                },
                error: function (data) {
                    console.log(data);
                }
            });
        }
    });

});