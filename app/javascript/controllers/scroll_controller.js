import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="scroll"
export default class extends Controller {
  connect() {
    this.scrollToBottom();
    document.addEventListener('turbo:before-stream-render', () => {
      this.scrollToBottom();
    });
  }

  scrollToBottom() {
    this.element.scrollTop = this.element.scrollHeight;
  }
}
