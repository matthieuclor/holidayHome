<template>
  <div>
    <hr class="my-4">

    <h4 class="d-flex align-items-center mb-3">
      Salle de bains :
      <span class="badge badge-secondary ml-2">
        {{ bathrooms.length }}
      </span>
    </h4>

    <div class="shadow p-3 rounded mb-3">
      <p class="text-muted m-0">
        <span v-for="(bathroom, index) in bathrooms" :key="bathroom.id">
          <span v-if="index > 0">&bull;</span>
          {{ bathroom.name }}
        </span>
      </p>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'Bathrooms',
    props: ['bathrooms']
  }
</script>
