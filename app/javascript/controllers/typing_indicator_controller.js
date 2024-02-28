import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="typing-indicator"
export default class extends Controller {
  static targets = ["indicator"]

  connect() {
    this.indicatorTarget.classList.add("hidden");
  }

  show() {
    this.indicatorTarget.classList.remove("hidden");
  }
}
