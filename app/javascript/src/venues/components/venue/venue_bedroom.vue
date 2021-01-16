<template>
  <div>
    <hr class="my-4">

    <h4 class="d-flex align-items-center mb-3">
      Chambres :
      <span class="badge badge-secondary ml-2">
        {{ venueItem.bedroomsCount }}
      </span>
    </h4>

    <div class="shadow p-3 rounded mb-3">
      <span class="text-muted">
        {{ pluralize(venueItem.singleBedsCount, 'lit simple') }}
        <span>&bull;</span>
        {{ pluralize(venueItem.doubleBedsCount, 'lit double') }}
        <span>&bull;</span>
        {{ pluralize(venueItem.babyBedsCount, 'lit bébé') }}
      </span>
    </div>
  </div>
</template>

<script>
import textMixin from 'shared/mixins/text_mixin';
import { mapGetters } from 'vuex';

export default {
  name: 'VenueBedroom',
  mixins: [textMixin],
  computed: {
    ...mapGetters(['venueItem']),
  },
};
</script>
