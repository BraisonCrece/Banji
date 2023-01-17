import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="profileform"
// when the user selects a new avatar image, this controller will
// show a preview of the image before submitting the form
export default class extends Controller {
  static targets = ["input", "preview", "useravatar"]

  togglePreview() {
    this.useravatarTarget.classList.add("hidden")
    this.previewTarget.classList.remove("invisible")
    this.previewTarget.classList.remove("absolute")
  }

  showPreview() {
    const file = this.inputTarget.files[0]
    const reader = new FileReader()

    reader.onload = (event) => {
      this
        .previewTarget
        .setAttribute("src", event.target.result)
    }

    reader.readAsDataURL(file)

    this.togglePreview()

  }

  connect() {
    this.inputTarget.addEventListener("change", this.showPreview.bind(this))
  }
}

