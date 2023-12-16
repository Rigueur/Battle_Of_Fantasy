import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "qty", "foodCost", "goldCost", "energyCost", "level", "upgradeQty", "upgradeCost", "stats" ]

  connect() {
    if (this.hasLevelTarget && this.hasUpgradeQtyTarget && this.hasUpgradeCostTarget && this.hasStatsTarget) {
      this.updateUpgradeQty()
    }
  }

  updateCost(event) {
    let role = event.target.dataset.role;
    let qty = this.qtyTarget(role).value;
    let townId = this.element.dataset.townId;

    fetch(`/towns/${townId}/units/cost?role=${role}&level=1`)
      .then(response => response.json())
      .then(data => {
        this.foodCostTarget(role).textContent = qty * data.foodCost;
        this.goldCostTarget(role).textContent = qty * data.goldCost;
        this.energyCostTarget(role).textContent = qty * data.energyCost;
      });
  }

  qtyTarget(role) {
    return document.querySelector(`[data-unit-target='qty${role}']`);
  }

  foodCostTarget(role) {
    return document.querySelector(`[data-unit-target='foodCost${role}']`);
  }

  goldCostTarget(role) {
    return document.querySelector(`[data-unit-target='goldCost${role}']`);
  }

  energyCostTarget(role) {
    return document.querySelector(`[data-unit-target='energyCost${role}']`);
  }

  updateUpgradeQty() {
    const role = this.data.get("role")
    const level = this.levelTarget.value
    const count = JSON.parse(this.data.get("count"))
    this.upgradeQtyTarget.max = count[level] || 1
    const quantity = this.upgradeQtyTarget ? this.upgradeQtyTarget.value : 1

    // Make an AJAX request to get the upgrade cost
    fetch(`/units/upgrade_cost?role=${role}&level=${level}&quantity=${quantity}`)
    .then(response => response.json())
    .then(data => {
      // Update the cost in the view
      this.upgradeCostTarget.textContent = `Gold: ${data.cost.gold}, Food: ${data.cost.food}, Energy: ${data.cost.energy}`
      // Update the stats in the view
      this.statsTarget.innerHTML = `Hp: ${data.stats.hp}, Armor type: ${data.stats.armor_type}, Attack: ${data.stats.attack}, Attack type: ${data.stats.attack_type}, Speed: ${data.stats.speed}`
    })
  }
}
