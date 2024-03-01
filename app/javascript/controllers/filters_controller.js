import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="filters"
export default class extends Controller {
  static targets = ["form"]

  submit() {
    clearTimeout(this.timeout);
    this.timeout = setTimeout(() => {
      this.formTarget.requestSubmit();
    }, 200);
  }

  clear(event) {
    event.preventDefault();
    window.location.href = this.element.getAttribute('action');
  }
}
