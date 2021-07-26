var headerBackground = document.getElementById('headerBackground');
var headerLink = document.getElementById('headerLink').children;

$(document).ready(function () {
    if (history.scrollRestoration) {
        history.scrollRestoration = 'manual';
    } else {
        window.onbeforeunload = function () {
            window.scrollTo(0, 0);
        }
    }
    /* Scroll Top */
    var upToTop = $('#topButton');

    upToTop.on('click', function (e) {
        e.preventDefault();
        $('html, body').animate({scrollTop: 0}, '300');
    });
    /*********/
    /* Scroll Controller */
    $(window).scroll(function (e) {
        var scrollTop = $(window).scrollTop();

        var docHeight = $(document).height();
        var winHeight = $(window).height();
        var scrollPercent = (scrollTop) / (docHeight - winHeight);
        var scrollPercentRounded = Math.round(scrollPercent * 100);

        $('#scrollPercentLabel>span').html(scrollPercentRounded);
        if (scrollPercentRounded > 0) {
            headerBackground.setAttribute('style', 'opacity:' + scrollPercent * 50 + ';');
            headerLink[0].style.color = '#309937';
            headerLink[1].style.color = '#309937';
            $("#headerName").css("color", "#309937");
            $(".header-button").hover(function () {
                $(this).css("color", "#104E91");
            }, function () {
                $(this).css("color", "#309937");
            });
        } else {
            headerBackground.setAttribute('style', 'opacity: 0;');
            headerLink[0].style.color = '#FFF';
            headerLink[1].style.color = '#FFF';
            $("#headerName").css("color", "#FFF");
            $(".header-button").hover(function () {
                $(this).css("color", "#33BEEE");
            }, function () {
                $(this).css("color", "#FFF");
            });
        }
    });

});