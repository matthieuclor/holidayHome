<template>
  <div>
    <h4 class="d-flex align-items-center mb-3">
      Salle de bain :
    </h4>

    <div class="form-group row string required venue_bathrooms_count"
         :class="formGroupClass(venueFormItem, 'bathroomsCount')">

      <label class="string required col-sm-5 col-form-label text-nowrap"
             for="venue_bathrooms_count">

        Nombre de salles de bains <abbr title="obligatoire">*</abbr>
      </label>

      <div class="col-sm-3">
        <input :value="venueFormItem.bathroomsCount"
                class="form-control string required"
                :class="inputClass(venueFormItem, 'bathroomsCount')"
                required="required"
                aria-required="true"
                min="0"
                type="number"
                name="venue[bathrooms_count]"
                id="venue_bathrooms_count"
                :aria-invalid="!attributeIsValid(venueFormItem, 'bathroomsCount')">

        <div v-for="(bathroomsCountError, errorIndex) in venueFormItem.errors['bathroomsCount']"
             :key="errorIndex"
             class="invalid-feedback">

          {{ bathroomsCountError }}
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import formMixin from 'shared/mixins/form_mixin'
  import { mapGetters } from 'vuex'

  export default {
    name: 'VenueBathroomForm',
    mixins: [formMixin],
    computed: {
      ...mapGetters(['venueFormItem'])
    }
  }
</script>
