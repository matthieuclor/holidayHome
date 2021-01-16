import mutations from './mutations';
import actions from './actions';
import getters from './getters';

const state = {
  vehicleItems: [],
  vehicleVenueItem: null,
  vehicleFormItem: null,
};

export default {
  state,
  mutations,
  actions,
  getters,
};
