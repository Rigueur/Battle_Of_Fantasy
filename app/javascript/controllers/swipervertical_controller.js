import { Controller } from "@hotwired/stimulus"
import Swiper from "swiper/bundle"

// Connects to data-controller="swipervertical"
export default class extends Controller {
  connect() {
    var swiper = new Swiper(".swiper", {
      direction: 'vertical',
      grabCursor: true,
      mousewheel: {
        invert: false,
      },
      scrollbar: {
        el: ".swiper-scrollbar",
        draggable: true,
      },
      slidesPerView: 1,
      spaceBetween: 10,
      // Responsive breakpoints
      breakpoints: {
        900: {
          slidesPerView: 2,
          spaceBetween: 20,
        },
        1200: {
          slidesPerView: 3,
          spaceBetween: 30,
        },
      },
    });
  }
}
