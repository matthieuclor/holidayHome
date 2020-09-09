<template>
  <div class="form-group row string required venue_name"
       :class="formGroupClass(venueFormItem, 'name')">

    <label for="venue_name"
           class="string required col-sm-2 col-form-label text-nowrap">

      Nom <abbr title="obligatoire">*</abbr>
    </label>

    <div class="col-sm-10">
      <input placeholder="Chalet à la montagne"
             required="required"
             aria-required="true"
             type="text"
             :value="venueFormItem.name"
             name="venue[name]"
             id="venue_name"
             class="form-control string required"
             :class="inputClass(venueFormItem, 'name')"
             :aria-invalid="!attributeIsValid(venueFormItem, 'name')">
    </div>
  </div>
</template>

<script>
  import formMixin from 'shared/mixins/form_mixin'
  import { mapGetters } from 'vuex'

  export default {
    name: 'VenueNameForm',
    computed: {
      ...mapGetters(['venueFormItem'])
    },
    mixins: [formMixin]
  }
</script>
