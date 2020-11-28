<template>
  <div class="form-group text optional venue_comment"
       :class="formGroupClass(venueFormItem, 'comment')">

    <label for="venue_comment" class="text optional">
      Commentaire
    </label>
    <textarea placeholder="Choses à savoir, bon plan, précision sur le lieu..."
              :value="venueFormItem.comment"
              class="form-control text optional"
              :class="inputClass(venueFormItem, 'comment')"
              name="venue[comment]"
              id="venue_comment"
              :aria-invalid="!attributeIsValid(venueFormItem, 'comment')">
    </textarea>
  </div>
</template>

<script>
import formMixin from 'shared/mixins/form_mixin';
import { mapGetters } from 'vuex';

export default {
  name: 'VenueCommentForm',
  mixins: [formMixin],
  computed: {
    ...mapGetters(['venueFormItem']),
  },
};
</script>
