<template>
  <div>
    <hr class="my-4">

    <h4 class="d-flex align-items-center mb-3">
      Clés :
      <span class="badge badge-secondary ml-2">
        {{ keys.length }}
      </span>
    </h4>

    <div v-for="key in keys"
          :key="key.id"
          class="shadow p-3 rounded mb-3">
      <span>{{ key.name }} :</span>
      <span class="text-muted">
        {{ `${key.owner.firstName} ${key.owner.lastName}` }}
      </span>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'Keys',
    props: ['keys']
  }
</script>
