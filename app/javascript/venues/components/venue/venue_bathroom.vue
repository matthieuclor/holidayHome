<template>
  <div>
    <hr class="my-4">

    <h4 class="d-flex align-items-center mb-3">
      Salle de bains :
      <span class="badge badge-secondary ml-2">
        {{ venueItem.bathroomsCount }}
      </span>
    </h4>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    name: 'VenueBathroom',
    computed: {
      ...mapGetters(['venueItem'])
    }
  }
</script>
