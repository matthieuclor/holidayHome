<template>
  <div>
    <hr class="my-4">

    <h4 class="d-flex align-items-center mb-3">
      Chambres :
      <span class="badge badge-secondary ml-2">
        {{ bedrooms.length }}
      </span>
    </h4>

    <div v-for="bedroom in bedrooms"
         :key="bedroom.id"
         class="shadow p-3 rounded mb-3">
      <h5>{{ bedroom.name }}</h5>
      <span>Lits :</span>
      <span class="text-muted">
        <span v-for="(bedding, index) in bedroom.beddings.filter((b) => b.bedCount > 0)"
            :key="bedding.id">
          <span v-if="index > 0">&bull;</span>
          {{ pluralize(bedding.bedCount, bedding.bedType) }}
        </span>
      </span>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'Bedrooms',
    props: ['bedrooms'],
    methods: {
      pluralize(count, string, suffix = 's') {
        return `${count} ${string}${count > 1 ? suffix : ''}`
      }
    }
  }
</script>
