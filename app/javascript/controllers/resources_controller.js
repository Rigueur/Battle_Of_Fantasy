import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { townId: Number, energyUpdate: Number, woodProduction: Number, stoneProduction: Number, foodProduction: Number, goldProduction: Number, lastUpdateTime: Number }

  connect() {
    this.calculateProduction()
    this.intervalId = setInterval(() => this.calculateProduction(), 60000)
  }

  disconnect() {
    clearInterval(this.intervalId)
  }

  async calculateProduction() {
    await new Promise(resolve => setTimeout(resolve, 1000));
    const now = new Date();
    this.lastUpdateTime = new Date(this.lastUpdateTimeValue * 1000); // Convert to milliseconds
    const minutesPassed = (now - this.lastUpdateTime) / 60000; // Convert milliseconds to minutes

    // if minutesPassed is less than 1, we don't need to update the resources
    if (minutesPassed < 1) {
      console.log('less than 1 minute passed, no ressources produced');
    } else {
      const woodProduced = this.woodProductionValue * minutesPassed;
      const stoneProduced = this.stoneProductionValue * minutesPassed;
      const foodProduced = this.foodProductionValue * minutesPassed;
      const goldProduced = this.goldProductionValue * minutesPassed;

      this.updateResources(woodProduced, stoneProduced, foodProduced, goldProduced);
    }

    this.energyUpdateTime = new Date(this.energyUpdateValue * 1000); // Convert to milliseconds
    const energyMinutesPassed = (now - this.energyUpdateTime) / 60000; // Convert milliseconds to minutes

    // if minutesPassed is less than 3, we don't need to update the energy
    if (energyMinutesPassed < 3) {
      return;
    } else {
      const energyProduced = Math.floor(energyMinutesPassed / 3);
      this.updateEnergy(energyProduced);
    }
  }

  async updateResources(wood, stone, food, gold) {
    await new Promise(resolve => setTimeout(resolve, 1000));


    const response = await fetch(`/towns/${this.townIdValue}/update_resources`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ wood, stone, food, gold })
    });

    if (response.ok) {
      const newFooterHtml = await response.text();
      document.querySelector('footer').innerHTML = newFooterHtml;
      console.log('Resources updated!');
    } else {
      console.error('Error updating resources:', response.statusText);
    }
  }

  async updateEnergy(energy) {
    await new Promise(resolve => setTimeout(resolve, 1000));

    const response = await fetch(`/towns/${this.townIdValue}/update_energy`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ energy })
    });

    if (response.ok) {
      // const newFooterHtml = await response.text();
      // document.querySelector('footer').innerHTML = newFooterHtml;
      console.log('Energy updated!');
    } else {
      console.error('Error updating energy:', response.statusText);
    }
  }
}
