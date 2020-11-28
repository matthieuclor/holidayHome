import mutations from './mutations';
import actions from './actions';
import getters from './getters';

const state = {
  currentUser: null,
};

const userModule = {
  state,
  mutations,
  actions,
  getters,
};

export default userModule;
