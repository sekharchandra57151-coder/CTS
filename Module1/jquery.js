
$(document).ready(function () {
    console.log("jQuery Loaded Successfully!");

    // Exercise 2: Change heading text
    $("h1").text("Welcome to the Community Event Portal");

    // Hide paragraph when button clicked
    $("#hideBtn").click(function () {
        $("p:first").hide();
    });

    // Show paragraph
    $("#showBtn").click(function () {
        $("p:first").show();
    });

    // Fade out event cards
    $("#fadeOutBtn").click(function () {
        $(".eventCard").fadeOut();
    });

    // Fade in event cards
    $("#fadeInBtn").click(function () {
        $(".eventCard").fadeIn();
    });

    // Toggle event cards
    $("#toggleBtn").click(function () {
        $(".eventCard").toggle();
    });

    // Bonus: Chain methods
    $("#animateBtn").click(function () {
        $(".eventCard")
            .slideUp()
            .delay(1000)
            .slideDown();
    });

    // Exercise 4: Add list item dynamically
    $("#addItemBtn").click(function () {
        let itemText = $("#itemInput").val();

        if (itemText !== "") {
            $("<li></li>")
                .text(itemText)
                .appendTo("#itemList");

            $("#itemInput").val("");
        }
    });

    // Remove all list items
    $("#removeAllBtn").click(function () {
        $("#itemList").empty();
    });

    // Exercise 5: Change color on click
    $("#colorBtn").click(function () {
        $("#colorBox").css("background-color", "red");
    });

    // Double click to reset color
    $("#colorBox").dblclick(function () {
        $(this).css("background-color", "white");
    });

    // Mouse enter / leave
    $("#hoverBox").mouseenter(function () {
        $(this).css("background-color", "lightblue");
        $(this).text("Mouse Entered!");
    });

    $("#hoverBox").mouseleave(function () {
        $(this).css("background-color", "lightgray");
        $(this).text("Mouse Left!");
    });

    // Keypress event
    $("#keyInput").keypress(function (event) {
        $("#keyOutput").text(
            "You pressed: " + String.fromCharCode(event.which)
        );
    });
});