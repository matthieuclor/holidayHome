import mutations from './mutations';
import actions from './actions';
import getters from './getters';

const state = {
  calendar: null,
  formCalendar: null,
};

const calendarModule = {
  state,
  mutations,
  actions,
  getters,
};

export default calendarModule;
