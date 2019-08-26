// toggle navbar menu

var menuBtn = document.getElementById('burger-btn');
var menuItems = document.getElementById('menu-items');

menuBtn.addEventListener("click", (event) => {
  menuItems.classList.toggle('invisible');
});


// parralax run with data sets

window.addEventListener('scroll', function(e) {

    const target = document.querySelector('.scroll');
    const limit = target.offsetHeight + target.offsetTop;

    var condition = window.pageYOffset > (target.offsetTop) && window.pageYOffset <= (limit);

    var pos = (window.pageYOffset - target.offsetTop) * target.dataset.rate;

    if(condition) {
      console.log('ouf');
      target.style.transform = 'translate3d(0px,'+pos+'px, 0px)';
    } else {
      console.log('nouf')
    }
});

