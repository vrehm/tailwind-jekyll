// toggle navbar menu

var menuBtn = document.getElementById('burger-btn');
var menuItems = document.getElementById('menu-items');


menuBtn.addEventListener("click", (event) => {
  menuItems.style.display = menuItems.style.display === 'none' ? '' : 'none';
});

console.log("hello thibault");
