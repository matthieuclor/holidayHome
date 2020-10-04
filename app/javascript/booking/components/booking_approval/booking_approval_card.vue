<template>
  <div v-if="bookingApprovals.length > 0" class="accordion" id="accordion">
    <div class="card">
      <div class="card-header p-2" id="booking_approvals">
        <h2 class="mb-0">
          <button class="btn btn-link btn-block text-muted"
                  type="button"
                  data-toggle="collapse"
                  data-target="#collapseOne"
                  aria-expanded="true"
                  aria-controls="collapseOne">

            Liste d'approbations :
            <span class="badge badge-secondary">
              {{ bookingApprovalsCount }}
            </span>
          </button>
        </h2>
      </div>

      <div id="collapseOne"
           class="collapse"
           aria-labelledby="booking_approvals"
           data-parent="#accordion">

        <div class="card-body p-2">
          <ul class="list-group list-group-flush">
            <li v-for="(bookingApproval, index) in bookingApprovals" :key="index"
                class="list-group-item border-0 p-1">

              <div class="d-flex justify-content-between align-items-center">
                <div>
                  <BookingCurrentUserIcon v-if="bookingStatus == 'pending'"
                                          :userId="bookingApproval.userId" />

                  <a v-if="bookingApproval.userName"
                    :href="`/user_account/users/${bookingApproval.userId}`"
                    data-remote="true">
                    {{ bookingApproval.userName }}
                  </a>

                  <i v-else class="fas fa-user-slash text-muted"></i>
                </div>

                <BookingApprovalStatusIcon :status="bookingApproval.status"
                                           :statusTitle="bookingApproval.statusTitle"/>
              </div>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import BookingCurrentUserIcon from '../booking/booking_current_user_icon'
  import BookingApprovalStatusIcon from './booking_approval_status_icon'

  export default {
    name: 'BookingApprovalCard',
    props: [
      'bookingApprovals',
      'bookingStatus'
    ],
    computed: {
      bookingApprovalsCount() {
        return this.bookingApprovals.length
      }
    },
    components: {
      BookingCurrentUserIcon,
      BookingApprovalStatusIcon
    }
  }
</script>
