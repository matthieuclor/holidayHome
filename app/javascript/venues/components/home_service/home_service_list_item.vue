<template>
  <div class="shadow p-3 rounded mb-3">
    <h5 class="text-nowrap mb-3">
      <i class="fas fa-id-card mr-1"></i>
      {{ homeService.name }}
    </h5>

    <div class="d-flex flex-row">
      <h5 class="text-nowrap mr-3 pt-1">
        <i class="fas fa-user mr-1"></i>
        {{ homeService.personInCharge }}
      </h5>

      <ul class="list-group list-group-flush shadow-none">
        <li v-if="homeService.phone" class="list-group-item text-muted p-1">
          <i class="fas fa-phone mr-1"></i>
          {{ homeService.phone }}
        </li>
        <li v-if="homeService.email" class="list-group-item text-muted p-1">
          <i class="fas fa-envelope mr-1"></i>
          {{ homeService.email }}
        </li>
        <li v-if="homeService.address" class="list-group-item text-muted p-1">
          <i class="fas fa-map-marked mr-1"></i>
          {{ homeService.address }}
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
export default {
  name: 'HomeServiceListItem',
  props: ['homeService'],
};
</script>
