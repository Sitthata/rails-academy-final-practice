import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Checkbox controller connected")
  }

  submit() {
    this.element.requestSubmit()
  }
}
