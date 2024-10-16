function getSensitiveInformation(element){
	var cont = document.getElementById("review-container")

	fetch("/getSensitiveInformation", { method: "GET" })
		.then(response => response.json())
		.then(data => console.log(data))
  		.catch(error => console.error('Error:', error));
}

