<template>
  <div class="shadow p-3 rounded mb-3">
    <span>
      {{ digitalCode.name }} :
    </span>

    <span class="text-muted">
      {{ digitalCode.password }}
    </span>
  </div>
</template>

<script>
export default {
  name: 'DigitalCodeListItem',
  props: ['digitalCode'],
};
</script>
