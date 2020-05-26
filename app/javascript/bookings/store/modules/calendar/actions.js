import moment from 'moment'

export default {
  updateCalendar({ commit }, { month, year, monthCount }) {
    const minDate = moment(`${year}-${month}-01`, 'YYYY-MM-DD HH:mm:ss')
    const maxDate = minDate.clone().add(monthCount - 1, 'months').endOf('month')

    commit('UPDATE_CALENDAR', {
      minDate: minDate.format('YYYY-MM-DD HH:mm:ss'),
      maxDate: maxDate.format('YYYY-MM-DD HH:mm:ss')
    })
  },
  updateFormCalendar({ commit }, { month, year, monthCount }) {
    const minDate = moment(`${year}-${month}-01`, 'YYYY-MM-DD HH:mm:ss')
    const maxDate = minDate.clone().add(monthCount - 1, 'months').endOf('month')

    commit('UPDATE_FORM_CALENDAR', {
      minDate: minDate.format('YYYY-MM-DD HH:mm:ss'),
      maxDate: maxDate.format('YYYY-MM-DD HH:mm:ss')
    })
  }
}
