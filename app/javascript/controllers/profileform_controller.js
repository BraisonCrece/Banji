import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "preview"]

  showPreview() {
    const file = this.inputTarget.files[0]
    const reader = new FileReader()

    reader.onload = (event) => {
      this
        .previewTarget
        .setAttribute("src", event.target.result)
    }

    reader.readAsDataURL(file)
  }

  connect() {
    this.inputTarget.addEventListener("change", this.showPreview.bind(this))
  }
}

