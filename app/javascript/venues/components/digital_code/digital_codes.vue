<template>
  <div>
    <hr class="my-4">

    <h4 class="d-flex align-items-center mb-3">
      Digicodes :
      <span class="badge badge-secondary ml-2">
        {{ digitalCodes.length }}
      </span>
    </h4>

    <div v-for="digitalCode in digitalCodes"
          :key="digitalCode.id"
          class="shadow p-3 rounded mb-3">
      <span>
        {{ digitalCode.name }} :
      </span>

      <span class="text-muted">
        {{ digitalCode.password }}
      </span>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'DigitalCodes',
    props: ['digitalCodes']
  }
</script>
