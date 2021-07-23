/* 
    Created on : Jun 22, 2021, 5:56:03 PM
    Author     : Admin
*/
$(document).ready(function () {
    if (history.scrollRestoration) {
        history.scrollRestoration = 'manual';
    } else {
        window.onbeforeunload = function () {
            window.scrollTo(0, 0);
        }
    }
});

