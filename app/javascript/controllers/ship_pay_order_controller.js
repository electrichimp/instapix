import { Controller } from "stimulus";
import Rails, { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = ['coupon','form'];

  connect() {
  }

  send(e) {
  e.preventDefault()
  Rails.fire(this.formTarget, "submit")
  }

  coupon(e) {
    this.couponTarget.classList.toggle('d-none')
  }
}
