import TurbolinksAdapter from 'vue-turbolinks';
import Vue from 'vue/dist/vue.esm';
import store from 'booking/store';
import App from 'booking/app';

Vue.use(TurbolinksAdapter);

document.addEventListener('turbolinks:load', () => {
  const element = document.getElementById('booking-vue');

  if (element) {
    new Vue({ store, render: (h) => h(App) }).$mount(element);
  }
});
