<template>
  <div>
    <hr class="my-4">

    <h4 class="d-flex align-items-center mb-3">
      Clés :
      <span class="badge badge-secondary ml-2">
        {{ keys.length }}
      </span>
    </h4>

    <KeyListItem v-for="key in keys"
                 :key="key.id"
                 :keyItem="key" />

  </div>
</template>

<script>
  import KeyListItem from './key_list_item'

  export default {
    name: 'KeyList',
    props: ['keys'],
    components: {
      KeyListItem
    }
  }
</script>
