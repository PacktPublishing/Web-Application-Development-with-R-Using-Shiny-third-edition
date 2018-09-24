
shinyjs.buttonClick = function(params) {
  
  var defaultParams = {
    color : "black",
    size : "medium"
  };
  params = shinyjs.getParams(params, defaultParams);
  
  var elem = document.getElementById('selection');
  
  elem.innerHTML = document.getElementById('year').value;
  
  elem.style.color = params.color;
  
  elem.style.fontSize = params.size;
}