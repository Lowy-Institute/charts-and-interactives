const data = [
  {
    "province": 0,
    "name": "Vietnam",
    "id": 0,
    "eighteen": 0.49,
    "eighteen_b": 0.51,
    "twenty_two": 0.53,
    "twenty_two_b": 0.47
  },
  {
    "province": 0,
    "name": "Thailand",
    "id": 1,
    "eighteen": 0.50,
    "eighteen_b": 0.50,
    "twenty_two": 0.53,
    "twenty_two_b": 0.47
  },
  {
    "province": 0,
    "name": "Myanmar",
    "id": 2,
    "eighteen": 0.64,
    "eighteen_b": 0.34,
    "twenty_two": 0.66,
    "twenty_two_b": 0.36
  },
  {
    "province": 1,
    "name": "Cambodia",
    "id": 3,
    "eighteen": 0.65,
    "eighteen_b": 0.35,
    "twenty_two": 0.69,
    "twenty_two_b": 0.31
  },
  {
    "province": 1,
    "name": "Philippines",
    "id": 4,
    "eighteen": 0.43,
    "eighteen_b": 0.57,
    "twenty_two": 0.48,
    "twenty_two_b": 0.52
  },
  {
    "province": 1,
    "name": "Brunei",
    "id": 5,
    "eighteen": 0.58,
    "eighteen_b": 0.62,
    "twenty_two": 0.63,
    "twenty_two_b": 0.37
  },
  {
    "province": 1,
    "name": "Singapore",
    "id": 6,
    "eighteen": 0.49,
    "eighteen_b": 0.51,
    "twenty_two": 0.49,
    "twenty_two_b": 0.51
  },
  {
    "province": 1,
    "name": "Malaysia",
    "id": 7,
    "eighteen": 0.55,
    "eighteen_b": 0.45,
    "twenty_two": 0.63,
    "twenty_two_b": 0.37
  },
  {
    "province": 1,
    "name": "Laos",
    "id": 8,
    "eighteen": 0.72,
    "eighteen_b": 0.28,
    "twenty_two": 0.71,
    "twenty_two_b": 0.29
  },
  {
    "province": 1,
    "name": "Indonesia",
    "id": 9,
    "eighteen": 0.55,
    "eighteen_b": 0.45,
    "twenty_two": 0.60,
    "twenty_two_b": 0.40
  }
]


let vw = window.innerWidth;
/* let l = wrap.getBoundingClientRect().left;
let w = wrap.getBoundingClientRect().width; */

let polygons = document.querySelectorAll('#map path');
let wrap = document.querySelector('.wrapper');

// window.onload = maintainAspectRatio;
// window.addEventListener("resize", () => { vw = window.innerWidth; maintainAspectRatio(); });
// const maintainAspectRatio = function() { vw < 800 ? wrap.style.height = 0.75*vw  + 'px' : "" };

document.addEventListener("DOMContentLoaded", initialise);

function initialise() {
  let radios = document.querySelectorAll('input[type=radio]');
  radios.forEach( (r,i) => r.addEventListener('change', () => colorize(i) ) );
  polygons.forEach( (p,i) => addTooltip(p, i) );
  colorize(0);
}

function addTooltip(el,i) {
  el.addEventListener('mouseover', () => {

    let tooltip = document.querySelector('.tooltip');
    // let centroid = document.querySelectorAll('circle')[i];
    let commune = data.filter( c => c.id == el.dataset.id )[0];
    let box = el.getBoundingClientRect();
    let children = tooltip.children;

    children[0].innerHTML = commune.name;                          // Title
    children[1].style.background = getColor(commune.twenty_two);   // Coloured box
    children[2].innerHTML = Math.round(100*commune.twenty_two) + " China / " + Math.round(100*commune.twenty_two_b) + " United States ";    // Value
    children[4].style.background = getColor(commune.eighteen);
    children[5].innerHTML =  Math.round(100*commune.eighteen) + " China / " + Math.round(100*commune.eighteen_b) + " United States ";

    tooltip.style.left = box.left + box.width/2 - tooltip.offsetWidth/2 + 'px';
    tooltip.style.top = box.top - tooltip.offsetHeight - 5 + 'px';
    tooltip.style.opacity = 1;

    polygons.forEach( p => p.classList.add('fade'));
    el.classList.remove('fade');
  });

  el.addEventListener('mouseleave', () => {
    document.querySelector('.tooltip').style.opacity = 0;
    polygons.forEach( p => p.classList.remove('fade'));
  });
}

function colorize(d) {
  let dataset = d ? 'eighteen' : 'twenty_two';
  polygons.forEach( (poly, i) => {
    commune = data.filter( c => c.id == poly.dataset.id )[0];
    poly.style.fill = getColor(commune[dataset]);
  });
}

function getColor(n) {
  // n --> decimal number
  let colors = ["#539ed4","#75b1dd","#98c5e5","#bad8ee","#ddecf6","#ffd9dc","#ffb3b9","#ff8c96","#ff6673","#ff4050","#a96f92"];
  let i = n == 0.5 ? 10 :
          n < 0.30 ? 0 :
          n < 0.35 ? 1 :
          n < 0.40 ? 2 :
          n < 0.45 ? 3 :
          n < 0.5 ? 4 :
          n < 0.55 ? 5 :
          n < 0.6 ? 6 :
          n < 0.65 ? 7 :
          n < 0.7 ? 8 : 9;

  return colors[i];
}
