<template>
  <div>
    <hr class="my-4">

    <h4 class="d-flex align-items-center mb-3">
      Services à domicile :
      <span class="badge badge-secondary ml-2">
        {{ homeServices.length }}
      </span>
    </h4>

    <HomeServiceListItem v-for="homeService in homeServices"
                         :key="homeService.id"
                         :homeService="homeService" />

  </div>
</template>

<script>
import HomeServiceListItem from './home_service_list_item.vue';

export default {
  name: 'HomeServiceList',
  props: ['homeServices'],
  components: {
    HomeServiceListItem,
  },
};
</script>
