import TurbolinksAdapter from 'vue-turbolinks';
import Vue from 'vue/dist/vue.esm';
import store from 'venues/store';
import router from 'venues/router';
import App from 'venues/app';
// eslint-disable-next-line import/no-extraneous-dependencies
import * as Sentry from '@sentry/browser';
import { Integrations } from '@sentry/tracing';

Vue.use(TurbolinksAdapter);

if (process.env.NODE_ENV === 'production') {
  Sentry.init({
    Vue,
    dsn: 'https://e66d2815b4a146e6b56197fad24e4337@o487204.ingest.sentry.io/5545737',
    environment: 'production',
    integrations: [
      new Integrations.BrowserTracing(),
    ],
    tracesSampleRate: 0.2,
  });
}

document.addEventListener('turbolinks:load', () => {
  const element = document.getElementById('venues-vue');
  if (element) {
    new Vue({
      store,
      router,
      render: (h) => h(App),
    }).$mount(element);
  }
});
