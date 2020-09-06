import axios from 'axios'
import qs from 'qs'

export default {
  updateApproval({ commit }, { bookingId, approvalId, status, message }) {
    const csrfToken = document.querySelector('[name=csrf-token]').content

    return new Promise((resolve, reject) => {
      axios(
        {
          method: 'put',
          url: `/user_account/bookings/${bookingId}/booking_approvals/${approvalId}.json`,
          data: qs.stringify({
            booking_approval: {
              status: status,
              message_attributes: {
                content: message
              }
            }
          }),
          headers: { 'X-CSRF-TOKEN': csrfToken }
        }
      ).then(response => {
        commit('UPDATE_FLASHES', response.data.flashes)
        commit('UPDATE_BOOKING_APPROVAL_MODAL_FORM', false)
        resolve(response)
      }).catch(error => {
        commit('UPDATE_FLASHES', error.response.data.flashes)
        reject(error)
      })
    })
  },
  updateApprovalItem({ commit }, value) {
    commit('UPDATE_BOOKING_APPROVAL_ITEM', value)
  },
  updateApprovalModalForm({ commit }, value) {
    commit('UPDATE_BOOKING_APPROVAL_MODAL_FORM', value)
  }
}
