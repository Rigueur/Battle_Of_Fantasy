import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "qty", "foodCost", "goldCost", "energyCost", "level", "upgradeQty", "upgradeCost", "hp", "dtype", "attack", "atype", "speed", "stealth", "unitlevel" ]

  connect() {
    if (this.hasLevelTarget && this.hasUpgradeQtyTarget && this.hasUpgradeCostTarget && this.hasHpTarget) {
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
      // Update the cost in the view <i class="fa-solid fa-tree fa-lg" style="color:green"></i> <%= structure.wood_cost %>  <i class="fa-solid fa-gem fa-lg" style="color: grey"></i> <%= structure.stone_cost %> <i class="fa-solid fa-coins fa-lg" style="color: yellow"></i> <%= structure.gold_cost %></p>
      this.upgradeCostTarget.innerHTML = `<i class="fa-solid fa-coins fa-lg" style="color: yellow"></i> ${data.cost.gold} <i class="fa-solid fa-burger fa-lg" style="color: beige"></i> ${data.cost.food} <i class="fa-solid fa-bolt fa-lg" style="color: orange"></i> ${data.cost.energy}`
      // Update the stats in the view
      this.hpTarget.innerHTML = `${data.stats.hp}<span style= "color: green; font-weight: bold;"> + ${data.new_stats.hp - data.stats.hp}</span>`
      this.dtypeTarget.innerHTML = `${data.stats.armor_type}`.charAt(0).toUpperCase() + `${data.stats.armor_type}`.slice(1)
      this.attackTarget.innerHTML = `${data.stats.attack}<span style= "color: green; font-weight: bold;"> + ${data.new_stats.attack - data.stats.attack}</span>`
      this.atypeTarget.innerHTML = `${data.stats.attack_type}`.charAt(0).toUpperCase() + `${data.stats.attack_type}`.slice(1)
      this.speedTarget.innerHTML = `${data.stats.speed}<span style= "color: green; font-weight: bold;"> + ${data.new_stats.speed - data.stats.speed}</span>`
      this.stealthTarget.innerHTML = `${data.stats.stealth}<span style= "color: green; font-weight: bold;"> + ${data.new_stats.stealth - data.stats.stealth}</span>`
      this.unitlevelTarget.innerHTML = `${data.stats.level}`
    })
  }
}
