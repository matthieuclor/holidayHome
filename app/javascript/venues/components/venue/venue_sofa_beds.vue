<template>
  <div>
    <hr class="my-4">

    <h4 class="d-flex align-items-center mb-3">
      Convertibles :
    </h4>

    <div class="shadow p-3 rounded mb-3">
      <span class="text-muted">
        {{ pluralize(venueItem.singleSofaBedsCount, 'simple') }}
        <span>&bull;</span>
        {{ pluralize(venueItem.doubleSofaBedsCount, 'double') }}
      </span>
    </div>
  </div>
</template>

<script>
import textMixin from 'shared/mixins/text_mixin';
import { mapGetters } from 'vuex';

export default {
  name: 'VenueSofaBeds',
  mixins: [textMixin],
  computed: {
    ...mapGetters(['venueItem']),
  },
};
</script>
