<script type="text/javascript">

// Shiny function to receive messages
Shiny.addCustomMessageHandler("sendMessage",
  function(message) {
    
    // call this before modifying the DOM
    Shiny.unbindAll();
    
    /* delete the dropdown if it already
       exists which it will the second 
       time this function is called */
       
    // get the dropdown and assign to element
		var element =  document.getElementById('mySelect');
		
		// if it already exists delete it
		if (element !== null)
		{
			element.parentNode.removeChild(element);
		}

    // Create empty array to store the options
		var theNumbers = [];
		
		// add ascending numbers up to the
		// value of the message
		for (var i = 1; i <= message; i++) {
			theNumbers.push(i);
		}
	
		// grab the div ready to write to it
		var theDiv = document.getElementById("output");
		
		// create a new dropdown
		var selectList = document.createElement("select");
		
		// give it a name and write it to the div
		selectList.setAttribute("id", "mySelect");
		theDiv.appendChild(selectList);

		// add the options
		for (var n = 0; n < theNumbers.length; n++) {
			var option = document.createElement("option");
			option.setAttribute("value", theNumbers[n]);
			option.text = theNumbers[n];
			selectList.appendChild(option);
		}
		
		// add an onchange function to call shinyRules
		// every time this input changes
		selectList.onchange = shinyRules;
		
		// add class to style nicely in Bootstrap
		selectList.className += "form-control";

		// call this when you've finished modifying the DOM
		Shiny.bindAll();
  });
  
shinyRules = function(){
  
  // define text array and pick random element
  var textArray = ['JavaScript Rules!', 'Shiny Rules!'];
  var randomNumber = Math.floor(Math.random()*textArray.length);
    
  // whenever this input changes send a message to the server
  Shiny.onInputChange("JsMessage", textArray[randomNumber]);
}

</script>