// 1. JavaScript Basics
console.log("Welcome to the Community Portal");

window.onload = function () {
    alert("Page fully loaded!");
    loadPreference();
};

// 2. Event Data
const eventName = "Music Festival";
const eventDate = "2026-06-20";
let availableSeats = 50;

console.log(`Event: ${eventName}, Date: ${eventDate}, Seats: ${availableSeats}`);

// 3. Form Submission
function submitForm() {
    const name = document.forms["eventForm"]["name"].value;
    const email = document.forms["eventForm"]["email"].value;

    if (name === "" || email === "") {
        alert("Please fill all required fields");
        return;
    }

    try {
        if (availableSeats > 0) {
            availableSeats--;
            document.getElementById("confirmation").innerHTML =
                `Registration successful! Remaining seats: ${availableSeats}`;
        } else {
            throw "No seats available!";
        }
    } catch (error) {
        alert(error);
    }
}

// 4. Validate Phone
function validatePhone() {
    let phone = document.getElementById("phone").value;

    if (phone.length < 10) {
        alert("Invalid phone number");
    }
}

// 5. Show Event Fee
function showFee() {
    let eventType = document.getElementById("eventType").value;
    let fee = "";

    switch (eventType) {
        case "Music":
            fee = "₹500";
            break;
        case "Food":
            fee = "₹300";
            break;
        case "Art":
            fee = "₹400";
            break;
    }

    document.getElementById("fee").innerText = `Event Fee: ${fee}`;

    // Save preference
    localStorage.setItem("preferredEvent", eventType);
}

// 6. Count Characters
function countChars() {
    let text = document.getElementById("feedback").value;
    document.getElementById("charCount").innerText = text.length;
}

// 7. Enlarge Image
function enlargeImage(img) {
    img.style.width = "400px";
    img.style.height = "300px";
}

// 8. Video Event
function videoReady() {
    document.getElementById("videoMessage").innerText =
        "Video ready to play!";
}

// 9. Local Storage Load
function loadPreference() {
    let savedEvent = localStorage.getItem("preferredEvent");

    if (savedEvent) {
        document.getElementById("eventType").value = savedEvent;
    }
}

// 10. Clear Storage
function clearPreferences() {
    localStorage.clear();
    sessionStorage.clear();
    alert("Preferences cleared!");
}

// 11. Geolocation
function findLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(
            showPosition,
            showError,
            { enableHighAccuracy: true, timeout: 5000 }
        );
    } else {
        alert("Geolocation not supported");
    }
}

function showPosition(position) {
    document.getElementById("location").innerHTML =
        `Latitude: ${position.coords.latitude}, Longitude: ${position.coords.longitude}`;
}

function showError(error) {
    switch (error.code) {
        case error.PERMISSION_DENIED:
            alert("Permission denied");
            break;
        case error.TIMEOUT:
            alert("Request timed out");
            break;
        default:
            alert("Unknown error");
    }
}

// 12. Before Exit Warning
function confirmExit() {
    return "Are you sure you want to leave?";
}

// 13. Arrays and Methods
let events = [
    "Music Festival",
    "Food Carnival",
    "Art Exhibition"
];

events.push("Baking Workshop");

let filteredEvents = events.filter(event =>
    event.includes("Music")
);

console.log(filteredEvents);

let eventCards = events.map(event =>
    `Workshop on ${event}`
);

console.log(eventCards);

// 14. Async Fetch API
async function fetchEvents() {
    try {
        let response = await fetch("https://jsonplaceholder.typicode.com/posts");
        let data = await response.json();
        console.log(data);
    } catch (error) {
        console.log("Fetch error:", error);
    }
}

fetchEvents();