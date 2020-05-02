<template>
  <div>
    <hr class="my-4">

    <h4 class="d-flex align-items-center mb-3">
      Services à domicile :
      <span class="badge badge-secondary ml-2">
        {{ homeServices.length }}
      </span>
    </h4>

    <div v-for="homeService in homeServices"
          :key="homeService.id"
          class="shadow p-3 rounded mb-3">
      <h5>{{ homeService.name }}</h5>

      <div class="d-flex align-items-center">
        <h5 class="text-nowrap mb-0 mr-4">
          <i class="fas fa-user mr-2"></i>
          {{ homeService.personInCharge }}
        </h5>

        <div class="d-flex flex-wrap text-muted m-0">
          <div v-if="homeService.phone" class="border rounded py-1 px-2 mr-2 mt-2">
            <i class="fas fa-phone mr-2"></i>
            {{ homeService.phone }}
          </div>

          <div v-if="homeService.email" class="border rounded py-1 px-2 mr-2 mt-2">
            <i class="fas fa-envelope mr-2"></i>
            {{ homeService.email }}
          </div>

          <div v-if="homeService.address" class="border rounded py-1 px-2 mr-2 mt-2">
            <i class="fas fa-map-marked mr-2"></i>
            {{ homeService.address }}
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'HomeServices',
    props: ['homeServices']
  }
</script>
