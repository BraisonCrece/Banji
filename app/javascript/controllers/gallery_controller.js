import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="gallery"
export default class extends Controller {
  static targets = ["images", "points", "imagesGallery"]

  connect() {
    // depending on the scroll position of the images gallery, the corresponding point will be highlighted
    // Obtener el enlace
    let links = this.pointsTargets
    this.pointsTargets[0].classList.add("bg-blue-500")
    let images = this.imagesTargets;


    // Recorrer todos los enlaces
    links.forEach((link) => {
      // Agregar un evento click a cada enlace
      link.addEventListener("click", (event) => {
        // Prevenir el comportamiento por defecto
        event.preventDefault();
        // Obtener el elemento al cual apunta el enlace
        let elemento = document.querySelector(link.getAttribute("href"));
        // Desplazarse suavemente hacia el elemento
        elemento.scrollIntoView({ behavior: "smooth" });

        // remove the bg-blue-500 class from all the points
        links.forEach((link) => {
          link.classList.remove("bg-blue-500")
        });
        event.target.classList.add("bg-blue-500")
      });

    })



  }









}
