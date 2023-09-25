const data = [
  {
    "province": 0,
    "name": "Milne Bay",
    "id": 0,
    "staff": 101176140,
    "service": 29526039,
    "capital": 69998503,
    "revenue": 11469005,
    "districts": 4,
    "llg": 16
  },
  {
    "province": 0,
    "name": "Hela",
    "id": 1,
    "staff": 63886718,
    "service": 26280839,
    "capital": 85442177,
    "revenue": 2466017,
    "districts": 4,
    "llg": 13
  },
  {
    "province": 0,
    "name": "Jiwaka",
    "id": 2,
    "staff": 91008521,
    "service": 35241160,
    "capital": 87343265,
    "revenue": 1798195,
    "districts": 3,
    "llg": 6
  },
  {
    "province": 1,
    "name": "Manus",
    "id": 3,
    "staff": 38525984,
    "service": 17551639,
    "capital": 33108844,
    "revenue": 3605222,
    "districts": 1,
    "llg": 12
  },
  {
    "province": 1,
    "name": "Morobe",
    "id": 4,
    "staff": 241628447,
    "service": 15718690,
    "capital": 229091837,
    "revenue": 218432286,
    "districts": 10,
    "llg": 34
  },
  {
    "province": 1,
    "name": "New Ireland",
    "id": 5,
    "staff": 76193488,
    "service": 4815414,
    "capital": 54688333,
    "revenue": 41216067,
    "districts": 2,
    "llg": 9
  },
  {
    "province": 1,
    "name": "Oro",
    "id": 6,
    "staff": 48189067,
    "service": 20175568,
    "capital": 67285714,
    "revenue": 7495517,
    "districts": 3,
    "llg": 10
  },
  {
    "province": 1,
    "name": "Southern Highlands",
    "id": 7,
    "staff": 155934109,
    "service": 33850161,
    "capital": 161592517,
    "revenue": 39591266,
    "districts": 5,
    "llg": 20
  },
  {
    "province": 1,
    "name": "Western",
    "id": 8,
    "staff": 77161228,
    "service": 18231331,
    "capital": 60407619,
    "revenue": 74442254,
    "districts": 4,
    "llg": 15
  },
  {
    "province": 1,
    "name": "Western Highlands",
    "id": 9,
    "staff": 152226559,
    "service": 10482901,
    "capital": 76662993,
    "revenue": 67462736,
    "districts": 4,
    "llg": 9
  },
  {
    "province": 1,
    "name": "West New Britain",
    "id": 10,
    "staff": 95555327,
    "service": 31154354,
    "capital": 58741497,
    "revenue": 20235482,
    "districts": 3,
    "llg": 12
  },
  {
    "province": 1,
    "name": "Sandaun",
    "id": 11,
    "staff": 79753864,
    "service": 38442785,
    "capital": 82003129,
    "revenue": 7464511,
    "districts": 4,
    "llg": 17
  },
  {
    "province": 1,
    "name": "East New Britain",
    "id": 12,
    "staff": 130744046,
    "service": 16128065,
    "capital": 77965986,
    "revenue": 40010734,
    "districts": 4,
    "llg": 18
  },
  {
    "province": 1,
    "name": "Enga",
    "id": 13,
    "staff": 112390212,
    "service": 31213095,
    "capital": 160204082,
    "revenue": 24181426,
    "districts": 6,
    "llg": 16
  },
  {
    "province": 1,
    "name": "East Sepik",
    "id": 14,
    "staff": 145073447,
    "service": 69918401,
    "capital": 164369388,
    "revenue": 19932516,
    "districts": 6,
    "llg": 26
  },
  {
    "province": 1,
    "name": "Gulf",
    "id": 15,
    "staff": 38092045,
    "service": 25287894,
    "capital": 54469388,
    "revenue": 964980,
    "districts": 2,
    "llg": 10
  },
  {
    "province": 1,
    "name": "Eastern Highlands",
    "id": 16,
    "staff": 162787960,
    "service": 50665075,
    "capital": 166078231,
    "revenue": 29338810,
    "districts": 8,
    "llg": 24
  },
  {
    "province": 1,
    "name": "Simbu",
    "id": 17,
    "staff": 116934668,
    "service": 37645289,
    "capital": 121402653,
    "revenue": 10302652,
    "districts": 6,
    "llg": 20
  },
  {
    "province": 1,
    "name": "Central",
    "id": 18,
    "staff":  103856888,
    "service":  33471012,
    "capital":  74708503,
    "revenue":  19058571,
    "districts": 5,
    "llg": 15
  },
  {
    "province": 1,
    "name": "National Central District",
    "id": 19,
    "staff": 0.55,
    "service": 0.45,
    "capital": 0.60,
    "revenue": 0.40,
    "districts": 0.53,
    "llg": 0.47
  },
  {
    "province": 1,
    "name": "Bougainville",
    "id": 20,
    "staff": 0,
    "service": 0,
    "capital": 0,
    "revenue": 0,
    "districts": 3,
    "llg": 12
  },
  {
    "province": 1,
    "name": "Madang",
    "id": 21,
    "staff": 151609987,
    "service": 46313718,
    "capital": 117429592,
    "revenue": 28633761,
    "districts": 6,
    "llg": 19
  }
]


let vw = window.innerWidth;
/* let l = wrap.getBoundingClientRect().left;
let w = wrap.getBoundingClientRect().width; */

let polygons = document.querySelectorAll('#map path');
let wrap = document.querySelector('.wrapper');

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

    children[0].innerHTML = commune.name;
    children[1].innerHTML = `
      <div class="left-text">Staff remuneration: </div>
      <div class="right-text">${formatNumber(commune.staff)}</div>
    `;
    children[2].innerHTML = `
      <div class="left-text">Service delivery costs:&nbsp;</div>
      <div class="right-text">${formatNumber(commune.service)}</div>
    `;
    children[3].innerHTML = `
    <div class="left-text">Capital expenditure: </div>
    <div class="right-text">${formatNumber(commune.capital)}</div>
    `;
    children[4].innerHTML = `
    <div class="left-text">Revenue: </div>
    <div class="right-text">${formatNumber(commune.revenue)}</div>
    `;
    children[5].innerHTML = `
    <div class="left-text">Districts: </div>
    <div class="right-text">${commune.districts}</div>
    `;
    children[6].innerHTML = `
    <div class="left-text">Local-level governments: </div>
    <div class="right-text">${commune.llg}</div>
    `;


    tooltip.style.left = box.left + box.width/2 - tooltip.offsetWidth/8 + 'px';
    tooltip.style.top = box.top + tooltip.offsetHeight/4 + 'px';
    tooltip.style.opacity = .9;

    polygons.forEach( p => p.classList.add('fade'));
    el.classList.remove('fade');
  });

  el.addEventListener('mouseleave', () => {
    document.querySelector('.tooltip').style.opacity = 0;
    polygons.forEach(p => {
      p.classList.remove('fade');
      // p.style.fill = 'your_default_color'; // Can set a default color here, rather than CSS if desired
    });
  });
}
// Function to format numbers, showing 0 for null or zero values, and formatting large numbers into millions
function formatNumber(value) {
  if (value === null || value === 0) {
    return 'n/a';
  } else {
    return (value / 1e6).toLocaleString(undefined, { maximumFractionDigits: 2 }) + ' million';
  }
}