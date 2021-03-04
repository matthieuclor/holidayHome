import axios from 'axios';

export default {
  getVehicleItems({ commit }, venueId) {
    axios.get(`/user_account/venues/${venueId}/vehicles.json`).then((response) => {
      commit('UPDATE_VEHICLE_ITEMS', response.data.vehicles);
      commit('UPDATE_VEHICLE_VENUE_ITEM', response.data.venue);
    });
  },
  getVehicleFormItem({ commit }, { venueId, id }) {
    const url = `/user_account/venues/${venueId}/vehicles/${id ? `${id}/edit.json` : 'new.json'}`;

    axios.get(url).then((response) => {
      commit('UPDATE_VEHICLE_FORM_ITEM', response.data.vehicle);
    });
  },
  getVehicleTypeSuggestions(_, query) {
    return new Promise((resolve, reject) => {
      axios.get(`/user_account/vehicle_types.json?q[name_i_cont]=${query}`)
        .then((response) => {
          resolve(response);
        }).catch((error) => {
          reject(error);
        });
    });
  },
  sendVehicleForm({ commit }, formData) {
    const csrfToken = document.querySelector('[name=csrf-token]').content;
    const vehicleId = formData.get('vehicle[id]');
    const venueId = formData.get('vehicle[venue_id]');
    const method = vehicleId ? 'patch' : 'post';
    const url = `/user_account/venues/${venueId}/vehicles${vehicleId ? `/${vehicleId}` : ''}.json`;

    return new Promise((resolve, reject) => {
      axios(
        {
          method,
          url,
          data: formData,
          headers: { 'X-CSRF-TOKEN': csrfToken },
        },
      ).then((response) => {
        commit('UPDATE_FLASHES', response.data.flashes);
        commit('UPDATE_PLAN_ERROR', null);
        resolve(response);
      }).catch((error) => {
        commit('UPDATE_FLASHES', error.response.data.flashes);
        commit('UPDATE_VEHICLE_FORM_ITEM', error.response.data.vehicle);
        reject(error);
      });
    });
  },
  destroyVehicleItem({ commit, dispatch }, { venueId, id }) {
    const csrfToken = document.querySelector('[name=csrf-token]').content;

    return new Promise((resolve, reject) => {
      axios.delete(
        `/user_account/venues/${venueId}/vehicles/${id}.json`,
        { headers: { 'X-CSRF-TOKEN': csrfToken } },
      ).then((response) => {
        dispatch('getVehicleItems', venueId);
        commit('UPDATE_FLASHES', response.data.flashes);
        resolve(response);
      }).catch((error) => {
        commit('UPDATE_FLASHES', error.response.data.flashes);
        reject(error);
      });
    });
  },
};
