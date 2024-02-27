import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="filters"
export default class extends Controller {
  static targets = ["form"]

  connect() {
    console.log("Filters controller connected");
  }

  submit() {
    clearTimeout(this.timeout);
    this.timeout = setTimeout(() => {
      this.formTarget.requestSubmit();
    }, 200);
  }

  clear(event) {
    console.log("Clearing filters"); // Debugging statement
    event.preventDefault();
    window.location.href = this.element.getAttribute('action');
  }
}
