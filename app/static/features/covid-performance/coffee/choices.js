// Adapted from Sarah Higley on Codepen: https://codepen.io/smhigley/pen/gObMVzv

// ---------------- helpers & definitions ----------------- //

const options = [ "Albania","Argentina","Armenia","Australia","Austria","Bahrain","Bangladesh","Belarus","Belgium","Bhutan","Bolivia","Bosnia and Herzegovina","Brazil","Bulgaria","Canada","Cape Verde","Chile","China","Colombia","Costa Rica","Cote d'Ivoire","Croatia","Cuba","Cyprus","Czech Republic","Democratic Republic of Congo","Denmark","Dominican Republic","Ecuador","El Salvador","Estonia","Ethiopia","Finland","France","Gambia","Germany","Ghana","Greece","Guatemala","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Israel","Italy","Jamaica","Japan","Jordan","Kazakhstan","Kenya","Kuwait","Latvia","Libya","Lithuania","Luxembourg","Madagascar","Malawi","Malaysia","Malta","Mauritania","Mexico","Mongolia","Morocco","Mozambique","Myanmar","Namibia","Nepal","Netherlands","New Zealand","Nigeria","North Macedonia","Norway","Oman","Pakistan","Panama","Paraguay","Peru","Philippines","Poland","Portugal","Qatar","Romania","Russia","Rwanda","Saudi Arabia","Senegal","Serbia","Singapore","Slovakia","Slovenia","South Africa","South Korea","Spain","Sri Lanka","Sweden","Switzerland","Taiwan","Thailand","Togo","Trinidad and Tobago","Tunisia","Turkey","Uganda","Ukraine","United Arab Emirates","United Kingdom","United States","Uruguay","Vietnam","Zambia","Zimbabwe" ]

const caveated = ["China", "Sweden"]

const colors = ["#33ffdd",
                "#33cfff",
                "#339eff",
                "#d25aff",
                "#ff5ae0",
                "#ff7be0"]

var activeList = [];

const Keys = {
  Backspace: 'Backspace',
  Clear: 'Clear',
  Down: 'ArrowDown',
  End: 'End',
  Enter: 'Enter',
  Escape: 'Escape',
  Home: 'Home',
  Left: 'ArrowLeft',
  PageDown: 'PageDown',
  PageUp: 'PageUp',
  Right: 'ArrowRight',
  Space: ' ',
  Tab: 'Tab',
  Up: 'ArrowUp'
}

const MenuActions = {
  Close: 0,
  CloseSelect: 1,
  First: 2,
  Last: 3,
  Next: 4,
  Open: 5,
  Previous: 6,
  Select: 7,
  Space: 8,
  Type: 9
}

// filter an array of options against an input string
// returns an array of options that begin with the filter string, case-independent
function filterOptions(options = [], filter, exclude = []) {
  return options.filter((option) => {
    const matches = option.toLowerCase().indexOf(filter.toLowerCase()) === 0;
    return matches && exclude.indexOf(option) < 0;
  });
}

// return an array of exact option name matches from a comma-separated string
function findMatches(options, search) {
  const names = search.split(',');
  return names.map((name) => {
    const match = options.filter((option) => name.trim().toLowerCase() === option.toLowerCase());
    return match.length > 0 ? match[0] : null;
  })
  .filter((option) => option !== null);
}

// return combobox action from key press
function getActionFromKey(event, menuOpen) {
  const { key, altKey, ctrlKey, metaKey } = event;
  // handle opening when closed
  if (!menuOpen && (key === Keys.Down || key === Keys.Enter || key === Keys.Space)) {
    return MenuActions.Open;
  }

  // handle keys when open
  if (key === Keys.Down) {
    return MenuActions.Next;
  }
  else if (key === Keys.Up) {
    return MenuActions.Previous;
  }
  else if (key === Keys.Home) {
    return MenuActions.First;
  }
  else if (key === Keys.End) {
    return MenuActions.Last;
  }
  else if (key === Keys.Escape) {
    return MenuActions.Close;
  }
  else if (key === Keys.Enter) {
    return MenuActions.CloseSelect;
  }
  else if (key === Keys.Space) {
    return MenuActions.Space;
  }
  else if (key === Keys.Backspace || key === Keys.Clear || (key.length === 1 && !altKey && !ctrlKey && !metaKey)) {
    return MenuActions.Type;
  }
}

// get index of option that matches a string
// if the filter is multiple iterations of the same letter (e.g "aaa"),
// then return the nth match of the single letter
function getIndexByLetter(options, filter) {
  const firstMatch = filterOptions(options, filter)[0];
  const allSameLetter = (array) => array.every((letter) => letter === array[0]);
  
  if (firstMatch) {
    return options.indexOf(firstMatch);
  }
  else if (allSameLetter(filter.split(''))) {
    const matches = filterOptions(options, filter[0]);
    const matchIndex = (filter.length - 1) % matches.length;
    return options.indexOf(matches[matchIndex]);
  }
  else {
    return -1;
  }
}

// get updated option index
function getUpdatedIndex(current, max, action) {
  switch(action) {
    case MenuActions.First:
      return 0;
    case MenuActions.Last:
      return max;
    case MenuActions.Previous:
      return Math.max(0, current - 1);
    case MenuActions.Next:
      return Math.min(max, current + 1);
    default:
      return current;
  }
}

// check if an element is currently scrollable
function isScrollable(element) {
  return element && element.clientHeight < element.scrollHeight;
}

// ensure given child element is within the parent's visible scroll area
function maintainScrollVisibility(activeElement, scrollParent) {
  const { offsetHeight, offsetTop } = activeElement;
  const { offsetHeight: parentOffsetHeight, scrollTop } = scrollParent;

  const isAbove = offsetTop < scrollTop;
  const isBelow = (offsetTop + offsetHeight) > (scrollTop + parentOffsetHeight);

  if (isAbove) {
    scrollParent.scrollTo(0, offsetTop);
  }
  else if (isBelow) {
    scrollParent.scrollTo(0, offsetTop - parentOffsetHeight + offsetHeight);
  }
}

// ---------------- MULTISELECT ----------------- //

const Multiselect = function(el, options) {
 // element refs
 this.el = el;
 this.inputEl = el.querySelector('input');
 this.listboxEl = el.querySelector('[role=listbox]');

 this.idBase = this.inputEl.id;
 this.selectedEl = document.getElementById(`${this.idBase}-selected`);

 // data
 this.options = options;

 // state
 this.activeIndex = 0;
 this.open = false;
}

Multiselect.prototype.init = function() {
 this.inputEl.addEventListener('input', this.onInput.bind(this));
 this.inputEl.addEventListener('blur', this.onInputBlur.bind(this));
 // this.inputEl.addEventListener('click', () => this.updateMenuState(true));
 this.inputEl.addEventListener('keydown', this.onInputKeyDown.bind(this));
 this.listboxEl.addEventListener('blur', this.onInputBlur.bind(this));

 this.options.map((option, index) => {
   const optionEl = document.createElement('div');
   optionEl.setAttribute('role', 'option');
   optionEl.id = `${this.idBase}-${index}`;
   optionEl.className = index === 0 ? 'option option-current' : 'option';
   optionEl.setAttribute('aria-selected', 'false');
   optionEl.innerText = option;
   
   if (caveated.includes(option)) optionEl.classList.add('data-incomplete')

   optionEl.addEventListener('click', () => { this.onOptionClick(index); });
   optionEl.addEventListener('mousedown', this.onOptionMouseDown.bind(this));

   this.listboxEl.appendChild(optionEl);
   
 });
}

Multiselect.prototype.onInput = function() {
 const curValue = this.inputEl.value;
 const matches = filterOptions(this.options, curValue);
 
 if (curValue.length == 0) { this.updateMenuState(false, false); }
 else { this.updateMenuState(true); }

 // set activeIndex to first matching option
 // (or leave it alone, if the active option is already in the matching set)
 const filterCurrentOption = matches.filter((option) => option === this.options[this.activeIndex]);
 if (matches.length > 0 && !filterCurrentOption.length) {
   this.onOptionChange(this.options.indexOf(matches[0]));
 }
 
}

Multiselect.prototype.onInputKeyDown = function(event) {
 const max = this.options.length - 1;

 const action = getActionFromKey(event, this.open);

 switch(action) {
   case MenuActions.Next:
   case MenuActions.Last:
   case MenuActions.First:
   case MenuActions.Previous:
     event.preventDefault();
     event.stopPropagation();
     return this.onOptionChange(getUpdatedIndex(this.activeIndex, max, action));
   case MenuActions.CloseSelect:
     event.preventDefault();
     return this.updateOption(this.activeIndex);
   case MenuActions.Close:
     event.preventDefault();
     return this.updateMenuState(false);
   case MenuActions.Open:
     return this.updateMenuState(true);
 }
}

Multiselect.prototype.onInputBlur = function() {
 if (this.ignoreBlur) {
   this.ignoreBlur = false;
   return;
 }

 if (this.open) {
   this.updateMenuState(false, false);
 }
}

Multiselect.prototype.onOptionChange = function(index) {
 this.activeIndex = index;
 this.inputEl.setAttribute('aria-activedescendant', `${this.idBase}-${index}`);

 // update active style
 const options = this.el.querySelectorAll('[role=option]');
 [...options].forEach((optionEl) => {
   optionEl.classList.remove('option-current');
 });
 options[index].classList.add('option-current');

 if (this.open && isScrollable(this.listboxEl)) {
   maintainScrollVisibility(options[index], this.listboxEl);
 }
}

Multiselect.prototype.onOptionClick = function(index) {
 this.onOptionChange(index);
 this.updateOption(index);
 this.inputEl.focus();
}

Multiselect.prototype.onOptionMouseDown = function() {
 this.ignoreBlur = true;
}

Multiselect.prototype.removeOption = function(index) {

 const option = this.options[index];

 // update aria-selected
 const options = this.el.querySelectorAll('[role=option]');
 options[index].setAttribute('aria-selected', 'false');
 options[index].classList.remove('option-selected');

 // Update chart lines
 const buttonEl = document.getElementById(`${this.idBase}-remove-${index}`);
 const countryName = buttonEl.innerHTML.trim().replace(/[\*]/g,"")
 i = activeList.indexOf(countryName)
 activeList.splice(i, 1)
 this.updateLines(countryName, false)
 
 // remove button
 this.selectedEl.removeChild(buttonEl.parentElement);
 
 // If caveated selection removed, hide the note
 if ( caveated.includes(countryName) ) {
   document.querySelector(`.footnote .${countryName.toLowerCase()}`).classList.add('opacity-0')
   !activeList.some(c => caveated.includes(c)) ? document.querySelector('.sandbox .footnote').classList.remove('open') : ""
 }
}

Multiselect.prototype.selectOption = function(index) {
 const selected = this.options[index];
 this.activeIndex = index;

 // update aria-selected
 const options = this.el.querySelectorAll('[role=option]');
 
 if ( options[index].classList.contains('disabled') ) { return; }
 
 options[index].setAttribute('aria-selected', 'true');
 options[index].classList.add('option-selected');

 // add remove option button
 const buttonEl = document.createElement('button');
 const listItem = document.createElement('li');
 buttonEl.className = 'remove-option';
 buttonEl.type = 'button';
 buttonEl.id = `${this.idBase}-remove-${index}`;
 buttonEl.setAttribute('aria-describedby', `${this.idBase}-remove`);
 buttonEl.addEventListener('click', () => { this.removeOption(index); });
 buttonEl.innerHTML = caveated.includes(selected) ? selected + '* ' : selected + ' ';

 listItem.appendChild(buttonEl);
 this.selectedEl.appendChild(listItem);

}

Multiselect.prototype.updateOption = function(index) {
  
 let i
 const option = this.options[index];
 const optionEl = this.el.querySelectorAll('[role=option]')[index];
 const isSelected = optionEl.getAttribute('aria-selected') === 'true';
 const countryName = optionEl.innerHTML;

 if (isSelected) { 
   this.removeOption(index)
 }

 else {
   if (activeList.length < 5) {
     this.selectOption(index)
     activeList.push(countryName)
     this.updateLines(countryName, true)
     if (caveated.includes(countryName)) {
       document.querySelector('.sandbox .footnote').classList.add('open')
       document.querySelector(`.footnote .${countryName.toLowerCase()}`).classList.remove('opacity-0')
     }
   }
   else {
     // Flash placeholder text.
     for ( i=0; i<=600; i+=150 ) {
      setTimeout(() =>  this.inputEl.style.setProperty("--c", "#f7434c"), i);
      setTimeout(() =>  this.inputEl.style.setProperty("--c", "gray"), i+75);
     }
   }
 }

 this.inputEl.value = '';
 this.updateMenuState(false);
 
}

Multiselect.prototype.updateLines = function(country, add) {
  
  let el
  let targetLines = document.querySelectorAll(`[data-name="${country}"]`)
  let targetLabel = document.querySelector(`[data-countrylabel="${country}"]`)
  
  if (add) { 
    targetLines.forEach( e => e.classList.add('active','thicker') ) 
    targetLabel.classList.add('visible')
  }
  else {
    targetLabel.classList.remove('visible') 
    targetLabel.style.removeProperty('color') 
    targetLines.forEach( e => { 
      e.classList.remove('active','thicker')
      e.style.removeProperty('stroke')
    })
  }
  
  activeList.forEach( (country, i) => {
    el = document.querySelectorAll(`[data-name="${country}"]`)[1];
    lb = document.querySelector(`[data-countrylabel="${country}"]`);
    el.style.stroke = lb.style.color = colors[i];
  })
  
  // add country name to end
  
}

Multiselect.prototype.updateMenuState = function(open, callFocus = true) {
 this.open = open;

 this.inputEl.setAttribute('aria-expanded', `${open}`);
 open ? this.el.classList.add('open') : this.el.classList.remove('open');
 callFocus && this.inputEl.focus();
 
}

// init multiselect
const multiselectEl = document.querySelector('.js-multiselect');
const multiselectComponent = new Multiselect(multiselectEl, options);
multiselectComponent.init();
