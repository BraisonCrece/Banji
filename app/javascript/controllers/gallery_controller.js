import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="gallery"
export default class extends Controller {
  static targets = ["images_gallery", "point"]
  connect() {
    this.pointTargets.forEach((point, index) => {
      point.addEventListener("click", () => {
        let position = index
        let operation = position * (100 / (this.pointTargets.length))

        this.images_galleryTarget.style.transform = `translateX(${operation}%)`

        this.pointTargets.forEach((point) => {
          point.classList.remove("bg-blue-500")
        })
        point.classList.add("bg-blue-500")
      })
    })
  }
}
