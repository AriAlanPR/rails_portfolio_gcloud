async function saveWeatherSearched() {
    let weather = {
        city: document.getElementById("weathercity").innerText,
        degrees: document.getElementById("weatherdegrees").innerText,
        description: document.getElementById("weatherdescription").innerText
    }

    console.log("weather object", weather);

    let newWeather = await fetch("/weathers.json", {
        method: 'POST',
        headers: {
            "Content-Type": "application/json"
        }, 
        body: JSON.stringify(weather)
    });

    let resultWeather = await newWeather.json();

    if(newWeather.ok) {
        //do something with result
    } else {
        //do something if there's an error
    }
}