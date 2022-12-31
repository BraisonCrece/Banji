import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menu"
export default class extends Controller {
  connect() {
    console.log("Hello")
  }

  toggle(e) {
    console.log(e.target)
    if(e.target.classList.contains('menu_icon')){
      e.target.classList.remove('menu_icon')
      e.target.classList.add('menu_icon_up')
      document.querySelector('.menu_links').classList.remove('close')
    }else {
      e.target.classList.remove('menu_icon_up')
      e.target.classList.add('menu_icon')
      document.querySelector('.menu_links').classList.add('close')
    }
  }
}
