export default {
  UPDATE_BOOKING_APPROVAL_ITEMS(state, payload) {
    state.bookingApprovalItems = payload;
  },
  UPDATE_BOOKING_APPROVAL_ITEM(state, approval) {
    state.bookingApprovalItems = [
      ...state.bookingApprovalItems.filter((el) => el.id !== approval.id),
      approval,
    ];
  },
  UPDATE_BOOKING_APPROVAL_MODAL_FORM(state, payload) {
    state.approvalModalForm = payload;
  },
};
