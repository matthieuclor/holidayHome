<template>
  <div class="px-3 sidebar py-4 overflow-auto border-left"
       :class="{ active: sidebar }"
       style="height: calc(100vh - 56px);">

    <router-view></router-view>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    name: 'VenueContainer',
    computed: {
      ...mapGetters(['sidebar'])
    },
  }
</script>
