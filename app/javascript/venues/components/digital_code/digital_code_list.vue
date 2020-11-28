<template>
  <div>
    <hr class="my-4">

    <h4 class="d-flex align-items-center mb-3">
      Digicodes :
      <span class="badge badge-secondary ml-2">
        {{ digitalCodes.length }}
      </span>
    </h4>

    <DigitalCodeListItem v-for="digitalCode in digitalCodes"
                         :key="digitalCode.id"
                         :digitalCode="digitalCode" />

  </div>
</template>

<script>
import DigitalCodeListItem from './digital_code_list_item.vue';

export default {
  name: 'DigitalCodeList',
  props: ['digitalCodes'],
  components: {
    DigitalCodeListItem,
  },
};
</script>
