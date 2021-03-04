import axios from 'axios';
import qs from 'qs';

export default {
  getSchoolHolidayItems({ commit }, calendar) {
    axios.get('/user_account/school_holidays/range.json', { params: { ...calendar } })
      .then((response) => commit('UPDATE_SCHOOL_HOLIDAY_ITEMS', response.data.schoolHolidays));
  },
  update_current_school_holiday_zones({ commit }, { key, value }) {
    const csrfToken = document.querySelector('[name=csrf-token]').content;

    axios(
      {
        method: 'put',
        url: '/user_account/current_school_holiday_zones.json',
        data: qs.stringify({ zone: { key, value } }),
        headers: { 'X-CSRF-TOKEN': csrfToken },
      },
    ).then((response) => {
      commit('UPDATE_CURRENT_SCHOOL_HOLIDAY_ZONES', response.data.currentSchoolHolidayZones);
    }).catch((error) => {
      commit('UPDATE_FLASHES', error.response.data.flashes);
    });
  },
};
