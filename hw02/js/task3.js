// Toggles the display of the corresponding text on the right side
function showText(id) {
  var flag = document.getElementById(id).style.display;
  if (flag === "none" || flag === "") {
    document.getElementById(id).style.display = "inline";
  }
  else {
    document.getElementById(id).style.display = "none";
  }
}
