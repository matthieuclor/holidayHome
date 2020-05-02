<template>
  <div>
    <hr class="my-4">

    <h4 class="d-flex align-items-center mb-3">
      Réseaux :
      <span class="badge badge-secondary ml-2">
        {{ networks.length }}
      </span>
    </h4>

    <div v-for="network in networks"
          :key="network.id"
          class="shadow p-3 rounded mb-3">
      <span>Nom du réseau :</span>
      <span class="text-muted mr-3">
        {{ network.name }}
      </span>
      <span>Mot de passe :</span>
      <span class="text-muted">
        {{ network.password }}
      </span>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'Networks',
    props: ['networks']
  }
</script>
