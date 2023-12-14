import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="displaymenu"
export default class extends Controller {
  static targets = [ "menu", "icon" ]

  connect() {
    console.log("Hello")
  }

  display(event) {
    event.preventDefault();

    if (this.iconTarget.contains(event.target)) {
      this.menuTarget.classList.add('opacity')
      this.iconTarget.classList.add('background-opacity')
    } else {
      return
    }
  }

  remove(event) {
    event.preventDefault();

    if (this.iconTarget.contains(event.target) || this.menuTarget.contains(event.target)) return ;

    this.menuTarget.classList.remove('opacity');
    this.iconTarget.classList.remove('background-opacity');
  }
}
