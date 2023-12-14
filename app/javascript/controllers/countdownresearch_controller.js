import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["countdownresearch"]
  static values = { townId: Number, endTime: Number }

  connect() {
    this.endTime = new Date(this.endTimeValue * 1000) // Convert to milliseconds
    this.updateCountdown()
    this.intervalId = setInterval(() => this.updateCountdown(), 1000)
  }

  disconnect() {
    clearInterval(this.intervalId)
  }

  async updateCountdown() {
    await new Promise(resolve => setTimeout(resolve, 1000));
    var now = new Date();
    var timeRemaining = this.endTime - now;

    if (timeRemaining < 0) {
      clearInterval(this.intervalId);
      this.countdownresearchTarget.textContent = 'Research complete!';
      fetch('/towns/' + this.townIdValue + '/end_research', {
        method: 'POST',
        headers: {
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        }
      });
    } else {
      var seconds = Math.floor((timeRemaining / 1000) % 60);
      var minutes = Math.floor((timeRemaining / 1000 / 60) % 60);
      var hours = Math.floor((timeRemaining / (1000 * 60 * 60)) % 24);
      var days = Math.floor(timeRemaining / (1000 * 60 * 60 * 24));

      this.countdownresearchTarget.textContent = days + 'd ' + hours + 'h ' + minutes + 'm ' + seconds + 's ';
    }
  }
}
