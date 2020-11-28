import Vue from 'vue/dist/vue.esm';
import Vuex from 'vuex';
import venue from './modules/venue';
import booking from './modules/booking';
import calendar from './modules/calendar';
import user from './modules/user';
import schoolHoliday from './modules/school_holiday';
import flash from 'shared/store/modules/flash';
import planError from 'shared/store/modules/plan_error';

Vue.use(Vuex);

export default new Vuex.Store({
  modules: {
    venue,
    calendar,
    booking,
    user,
    schoolHoliday,
    flash,
    planError,
  },
});
