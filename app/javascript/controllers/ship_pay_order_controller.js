import { Controller } from "stimulus";
import Rails, { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = ['coupon','form'];

  connect() {
    console.log(this.element);
    console.log(this.formTarget);
  }

  send(e) {
  e.preventDefault()
  Rails.fire(this.formTarget, "submit")
  }

  coupon(e) {
    console.log(this.couponTarget)
    this.couponTarget.classList.toggle('d-none')
  }
}
