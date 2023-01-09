import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="gallery"
export default class extends Controller {
  static targets = ["images_gallery"]

  moveLeft(e) {
    e.preventDefault()
    this.images_galleryTarget.scrollLeft -= 500
  }

  moveRight(e) {
    e.preventDefault()
    this.images_galleryTarget.scrollLeft += 500
  }
}
