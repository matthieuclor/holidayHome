import mutations from './mutations';
import actions from './actions';
import getters from './getters';

const state = {
  bookingApprovalItems: [],
  approvalModalForm: false,
};

const bookingApprovalModule = {
  state,
  mutations,
  actions,
  getters,
};

export default bookingApprovalModule;
