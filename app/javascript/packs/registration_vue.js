import TurbolinksAdapter from 'vue-turbolinks';
import Vue from 'vue/dist/vue.esm';
import App from 'registration/app';

Vue.use(TurbolinksAdapter);

document.addEventListener('turbolinks:load', () => {
  const element = document.getElementById('registration-vue');

  if (element) {
    new Vue({ render: (h) => h(App) }).$mount(element);
  }
});
