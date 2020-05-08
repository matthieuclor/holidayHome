<template>
  <div class="shadow p-3 rounded mb-3">
    <span>Nom du réseau :</span>
    <span class="text-muted mr-3">
      {{ network.name }}
    </span>
    <span>Mot de passe :</span>
    <span class="text-muted">
      {{ network.password }}
    </span>
  </div>
</template>

<script>
  export default {
    name: 'NetworkListItem',
    props: ['network']
  }
</script>
