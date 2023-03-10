import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-options"
export default class extends Controller {
  static targets = ["searchMenu", "image"]

  toggle() {
    console.log(this.imageTarget);
    this.searchMenuTarget.classList.add("flex");
    this.searchMenuTarget.classList.toggle("hidden");
    this.imageTarget.classList.toggle("rotate-x-180");
    this.searchMenuTarget.classList.remove("-translate-y-full");
  }

  // When the key enter is pressed, the form is submitted
  submit() {
    this.element.submit();
    console.log(this.element);
  }



}
