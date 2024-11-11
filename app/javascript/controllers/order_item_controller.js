import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "formTemplate", "itemsList", "totalPrice"];
  static values = {
    patternToReplaceWithIndex: String
  }

  connect() {
    this.updateOrderTotal();
  }

  addItem(e) {
    e.preventDefault(); e.stopPropagation();

    this.itemsListTarget.insertAdjacentHTML('beforeend', this.generateFormHTML())
    this.updateOrderTotal();
  }

  removeItem(e) {
    e.preventDefault(); e.stopPropagation();

    if (this.itemsListTarget.childElementCount > 1) {
      e.target.closest(".order-item-fields").remove();
    } else {
      alert("O pedido deve conter pelo menos um item.");
    }
  }

  generateFormHTML() {
    const html = this.formTemplateTarget.innerHTML.toString()
    console.log(html)

    return html.replaceAll(this.patternToReplaceWithIndexValue, new Date().getTime())
  }

  updateTotal(event) {
    const selectedOption = event.target.selectedOptions[0];
    const price = parseFloat(selectedOption.dataset.price) || 0;
    const itemTotalPriceElement = event.target.closest(".order-item-fields").querySelector("[data-order-item-target='totalPrice']");
    itemTotalPriceElement.textContent = price.toFixed(2);
    this.updateOrderTotal();
  }

  updateOrderTotal() {
    let total = 0;
    this.itemsListTarget.querySelectorAll("[data-order-item-target='totalPrice']").forEach((priceElement) => {
      total += parseFloat(priceElement.textContent) || 0;
    });
    document.getElementById("order-total-price").textContent = total.toFixed(2);
  }
}