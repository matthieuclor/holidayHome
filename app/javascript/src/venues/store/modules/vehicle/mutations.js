export default {
  UPDATE_VEHICLE_ITEMS(state, payload) {
    state.vehicleItems = payload;
  },
  UPDATE_VEHICLE_VENUE_ITEM(state, payload) {
    state.vehicleVenueItem = payload;
  },
  UPDATE_VEHICLE_FORM_ITEM(state, payload) {
    state.vehicleFormItem = payload;
  },
};
