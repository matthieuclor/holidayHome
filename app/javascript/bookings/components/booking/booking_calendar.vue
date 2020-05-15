<template>
  <div class="d-flex justify-content-center mb-4">
    <div class="col-12">
      <v-calendar :columns="4"
                  :rows="3"
                  :is-expanded="true"
                  :attributes="attributes" />
    </div>
  </div>
</template>

<script>
  export default {
    name: 'BookingCalendar',
    data() {
      return {
        attributes: [
          {
            key: 'today',
            highlight: true,
            dates: new Date()
          }
        ]
      }
    }
  }
</script>
