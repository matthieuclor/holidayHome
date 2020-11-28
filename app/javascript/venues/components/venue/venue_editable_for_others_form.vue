<template>
  <fieldset class="form-group boolean venue_editable_for_others">
    <div class="custom-control custom-switch">
      <input name="venue[editable_for_others]"
             type="hidden"
             :value="venueFormItem.editableForOthers">

      <input type="checkbox"
             :value="venueFormItem.editableForOthers"
             :checked="venueFormItem.editableForOthers"
             @click="venueFormItem.editableForOthers = !venueFormItem.editableForOthers"
             name="venue[editable_for_others]"
             id="venue_editable_for_others"
             class="custom-control-input boolean">

      <label for="venue_editable_for_others"
             class="custom-control-label boolean">
        Editable par les autres membres
      </label>
    </div>
  </fieldset>
</template>

<script>
import { mapGetters } from 'vuex';

export default {
  name: 'VenueEditableForOthersForm',
  computed: {
    ...mapGetters(['venueFormItem']),
  },
};
</script>
