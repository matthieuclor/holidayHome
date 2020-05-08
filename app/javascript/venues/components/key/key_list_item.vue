<template>
  <div class="shadow p-3 rounded mb-3">
    <span>{{ keyItem.name }} :</span>
    <span class="text-muted">
      {{ `${keyItem.owner.firstName} ${keyItem.owner.lastName}` }}
    </span>
  </div>
</template>

<script>
  export default {
    name: 'KeyListItem',
    props: ['keyItem'],
  }
</script>
