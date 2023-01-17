import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="gallery"
export default class extends Controller {
  static targets = ["images", "points", "imagesGallery"]

  connect() {
    let links = this.pointsTargets
    let images = this.imagesTargets;
    this.pointsTargets[0].classList.add("bg-blue-500")

    links.forEach((link) => {
      link.addEventListener("click", (event) => {
        event.preventDefault();
        let elemento = document.querySelector(link.getAttribute("href"));
        elemento.scrollIntoView({ behavior: "smooth" });

        links.forEach((link) => {
          link.classList.remove("bg-blue-500")
        });

        event.target.classList.add("bg-blue-500")
      });

    })
  }

}
