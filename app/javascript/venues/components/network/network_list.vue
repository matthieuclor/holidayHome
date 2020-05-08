<template>
  <div>
    <hr class="my-4">

    <h4 class="d-flex align-items-center mb-3">
      Réseaux :
      <span class="badge badge-secondary ml-2">
        {{ networks.length }}
      </span>
    </h4>

    <NetworkListItem v-for="network in networks"
                     :key="network.id"
                     :network="network" />

  </div>
</template>

<script>
  import NetworkListItem from './network_list_item'

  export default {
    name: 'NetworkList',
    props: ['networks'],
    components: {
      NetworkListItem
    }
  }
</script>
