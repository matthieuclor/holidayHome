<template>
  <div class="modal" tabindex="-1" role="dialog" id="approvalModal">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h3 class="modal-title">
            <span v-if="status == 'accepted'" class="text-success">
              Approuver la réservation
            </span>
            <span v-else class="text-danger">
              Rejeter la réservation
            </span>
          </h3>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">
          <form @submit.prevent="submitApprovalForm"
                class="simple_form"
                accept-charset="UTF-8">

            <div class="form-group text required"
                 :class="formGroupClass(message, 'message.content')">

              <textarea v-model="message.content"
                        class="form-control text required"
                        :class="inputClass(message, 'message.content')"
                        rows="3"
                        placeholder="Ecrivez un message pour accompagner cette prise de décision"
                        required="required"
                        aria-required="true">
              </textarea>

              <div v-for="(messageError, errorIndex) in message.errors['message.content']"
                   :key="errorIndex"
                   class="invalid-feedback">

                {{ messageError }}
              </div>
            </div>

            <input type="submit"
                   name="commit"
                   value="Envoyer"
                   class="btn btn-sm btn-block btn-success"
                   :disabled="approvalFormIsSending">
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import formMixin from 'shared/mixins/form_mixin'
  import { mapGetters, mapActions} from 'vuex'

  export default {
    name: 'BookingApprovalForm',
    props: [
      'bookingId',
      'approvalId',
      'status'
    ],
    mixins: [formMixin],
    data() {
      return {
        approvalFormIsSending: false,
        message: {
          content: null,
          errors: []
        }
      }
    },
    computed: {
      ...mapGetters(['approvalModalForm'])
    },
    methods: {
      ...mapActions([
        'updateApproval',
        'updateApprovalModalForm'
      ]),
      submitApprovalForm() {
        this.approvalFormIsSending = true

        this.updateApproval(
          {
            bookingId: this.bookingId,
            approvalId: this.approvalId,
            status: this.status,
            message: this.message.content
          }
        ).then(response => {
          this.message.content = null
        }).catch(error => {
          this.message.errors = error.response.data.bookingApproval.errors
        }).then(() => {
            this.approvalFormIsSending = false
        })
      }
    },
    mounted() {
      $("#approvalModal").on('hidden.bs.modal', () => {
        this.updateApprovalModalForm(false)
      })
    },
    watch: {
      approvalModalForm() {
        if (this.approvalModalForm) {
          $("#approvalModal").modal('show')
        } else {
          $("#approvalModal").modal('hide')
        }
      },
      'message.content': function() {
        if (this.message.errors['message.content']) {
          this.message.errors = []
        }
      }
    }
  }
</script>
