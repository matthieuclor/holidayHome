<template>
  <div ref="toast"
       class="toast"
       :class="bgClass"
       role="alert"
       aria-live="assertive"
       aria-atomic="true"
       data-delay="4000">

    <div class="toast-body">
      <div class="d-flex align-items-center">
        <div class="fa-toast-type mr-3">
          <i class="fas mr-2" :class="iconClass"></i>
        </div>

        <div class="text-white font-weight-bold mr-2">
          {{ flash.value }}
        </div>

        <button type="button"
                class="ml-auto mb-1 close text-white"
                data-dismiss="toast"
                aria-label="Close">

          <span aria-hidden="true">&times;</span>
        </button>
      </div>
    </div>
  </div>
</template>

<script>
  import { mapActions } from 'vuex'

  export default {
    name: 'FlashMessage',
    props: ['flash'],
    computed: {
      ...mapActions(['clearFlashes']),
      bgClass() {
        return `bg-${this.flash.key == 'error' ? 'danger' : 'success' }`
      },
      iconClass() {
        return `${this.flash.key == 'error' ? 'times' : 'check' }-circle`
      }
    },
    mounted() {
      $(this.$refs.toast).toast("show")
      $(this.$refs.toast).on('hidden.bs.toast', () => this.clearFlashes)
    }
  }
</script>
