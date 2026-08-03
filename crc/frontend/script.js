const functionUrl = "https://funccloudresumeauedev01.azurewebsites.net/api/visitorcountercd ";

fetch(functionUrl)
    .then(response => response.json())
    .then(data => {
        document.getElementById("visitor-counter").innerHTML =
            "Visitors: " + data.count;
    })
    .catch(error => {
        console.error("Error fetching visitor count:", error);
        document.getElementById("visitor-counter").innerHTML =
            "Visitors: unavailable";
    });