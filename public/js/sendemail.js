async function sendEmail() {
    let target = {
        email: document.getElementById("txttestemail").value
    }

    console.log("target object", target);

    let newEmail = await fetch("/send_email.json", {
        method: 'POST',
        headers: {
            "Content-Type": "application/json"
        }, 
        body: JSON.stringify(target)
    });

    let resultEmail = await newEmail.json();

    if(newEmail.ok) {
        //do something with result
        console.log("Email response", resultEmail);
        alert(`response from server: ${resultEmail.state}`);
    } else {
        //do something if there's an error
        console.log("Email failure", resultEmail);
        alert('Error sending email');
    }
}