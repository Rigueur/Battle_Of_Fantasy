// battle_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "unit", "submitButton", "attackingTownId", "maxButton", "noneButton" ]

  connect() {
    this.maxButtonTargets.forEach(button => {
      button.addEventListener('click', () => this.updateEnergyCost());
    });

    this.noneButtonTargets.forEach(button => {
      button.addEventListener('click', () => this.updateEnergyCost());
    });
  }
  updateEnergyCost() {
    var units = {};
    this.unitTargets.forEach(function(input) {
      var match = input.name.match(/units\[(\w+)\]\[(\d+)\]/);
      var role = match[1];
      var level = match[2];
      if (!units[role]) units[role] = {};
      units[role][level] = input.value;
    });

    const attackingTownId = this.attackingTownIdTarget.value;

    fetch(`/towns/${attackingTownId}/battles/calculate_energy_cost`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ units: units, attacking_town_id: attackingTownId, defending_town_id: document.querySelector('input[name="battle[defending_town_id]"]:checked').value })
    })
    .then(response => response.json())
    .then(data => {
      if (data.error) {
        alert(data.error);
      } else {
        this.submitButtonTarget.value = 'Start Battle (Energy cost: ' + data.energy_cost + ')';
      }
    });
  }
}
