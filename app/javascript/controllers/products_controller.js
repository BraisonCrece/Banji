import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="products"
export default class extends Controller {
  enterToSubmit(e) {
    if (e.key === "Enter") {
      document.getElementById("price_filter").submit()
    }
  }
}
