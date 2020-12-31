import axios from 'axios';
import qs from 'qs';

export default {
  getVenueItems({ commit }, page = 1) {
    axios.get(`venues.json?page=${page}`).then((response) => {
      commit('UPDATE_VENUE_ITEMS', response.data.venues);
      commit('UPDATE_VENUE_PAGY', response.data.pagy);
    });
  },
  getVenueItem({ dispatch, commit }, id) {
    dispatch('removeVenueItem').then(() => {
      axios.get(`venues/${id}.json`).then((response) => {
        commit('UPDATE_VENUE_ITEM', response.data);
      });
    });
  },
  removeVenueItem({ commit }) {
    return new Promise((resolve) => {
      commit('UPDATE_VENUE_ITEM', null);
      resolve(true);
    });
  },
  getVenueFormItem({ commit }, id) {
    const url = `venues/${id ? `${id}/edit.json` : 'new.json'}`;

    axios.get(url).then((response) => {
      commit('UPDATE_VENUE_FORM_ITEM', response.data.venue);
      commit('UPDATE_VENUE_OWNER_FORM_ITEMS', response.data.owners);
    });
  },
  removePhoto({ commit }, { index, venueId, id }) {
    const csrfToken = document.querySelector('[name=csrf-token]').content;

    axios.delete(
      `venues/${venueId}/photos/${id}.json`,
      { headers: { 'X-CSRF-TOKEN': csrfToken } },
    ).then((response) => {
      commit('REMOVE_PHOTO', index);
      commit('UPDATE_FLASHES', response.data.flashes);
    }).catch((error) => {
      commit('UPDATE_FLASHES', error.response.data.flashes);
    });
  },
  addKey({ commit }) {
    commit('ADD_KEY', {
      id: null, name: null, Destroy: null, errors: {},
    });
  },
  removeKey({ commit }, index) {
    commit('REMOVE_KEY', index);
  },
  addNetwork({ commit }) {
    commit(
      'ADD_NETWORK',
      {
        id: null, name: null, password: null, Destroy: null, errors: {},
      },
    );
  },
  removeNetwork({ commit }, index) {
    commit('REMOVE_NETWORK', index);
  },
  addDigitalCode({ commit }) {
    commit(
      'ADD_DIGITAL_CODE',
      {
        id: null, name: null, password: null, Destroy: null, errors: {},
      },
    );
  },
  removeDigitalCode({ commit }, index) {
    commit('REMOVE_DIGITAL_CODE', index);
  },
  addHomeService({ commit }) {
    commit(
      'ADD_HOME_SERVICE',
      {
        id: null,
        name: null,
        personInCharge: null,
        address: null,
        phone: null,
        email: null,
        Destroy: null,
        errors: {},
      },
    );
  },
  removeHomeService({ commit }, index) {
    commit('REMOVE_HOME_SERVICE', index);
  },
  getAlgoliaPlacesSuggestions({ commit }, query) {
    const csrfToken = document.querySelector('[name=csrf-token]').content;

    return new Promise((resolve, reject) => {
      axios(
        {
          method: 'post',
          url: '/user_account/algolia_places.json',
          data: qs.stringify({ algolia_places: { query } }),
          headers: { 'X-CSRF-TOKEN': csrfToken },
        },
      ).then((response) => {
        resolve(response);
      }).catch((error) => {
        commit('UPDATE_FLASHES', error.response.data.flashes);
        reject(error);
      });
    });
  },
  sendVenueForm({ commit }, formData) {
    const csrfToken = document.querySelector('[name=csrf-token]').content;
    const venueId = formData.get('venue[id]');
    const method = venueId ? 'patch' : 'post';
    const url = `/user_account/venues${venueId ? `/${venueId}` : ''}.json`;

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

        if (error.response.data.planError) {
          commit('UPDATE_SIDEBAR', false);
          commit('UPDATE_PLAN_ERROR', error.response.data.planError);
        } else {
          commit('UPDATE_VENUE_FORM_ITEM', error.response.data.venue);
        }
        reject(error);
      });
    });
  },
  sendVenuePhotosForm({ commit }, { id, formData }) {
    const csrfToken = document.querySelector('[name=csrf-token]').content;

    return new Promise((resolve, reject) => {
      axios(
        {
          method: 'post',
          url: `/user_account/venues/${id}/photos.json`,
          data: formData,
          headers: {
            'X-CSRF-TOKEN': csrfToken,
            'Content-Type': 'multipart/form-data',
          },
        },
      ).then((response) => {
        commit('UPDATE_VENUE_FORM_ITEM', response.data.venue);
        commit('UPDATE_FLASHES', response.data.flashes);
        resolve(response);
      }).catch((error) => {
        commit('UPDATE_VENUE_FORM_ITEM', error.response.data.venue);
        commit('UPDATE_FLASHES', error.response.data.flashes);
        reject(error);
      });
    });
  },
  destroyVenueItem({ commit, dispatch }, id) {
    const csrfToken = document.querySelector('[name=csrf-token]').content;

    return new Promise((resolve, reject) => {
      axios.delete(
        `venues/${id}.json`,
        { headers: { 'X-CSRF-TOKEN': csrfToken } },
      ).then((response) => {
        commit('UPDATE_VENUE_ITEM', null);
        dispatch('getVenueItems');
        commit('UPDATE_FLASHES', response.data.flashes);
        commit('UPDATE_SIDEBAR', false);
        resolve(response);
      }).catch((error) => {
        commit('UPDATE_FLASHES', error.response.data.flashes);
        reject(error);
      });
    });
  },
  clearFlashes({ commit }) {
    commit('UPDATE_FLASHES', []);
  },
  showSidebar({ commit }) {
    commit('UPDATE_SIDEBAR', true);
  },
  hideSidebar({ commit }) {
    commit('UPDATE_SIDEBAR', false);
  },
};
