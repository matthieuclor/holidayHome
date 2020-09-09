<template>
  <div>
    <h4 class="d-flex align-items-center mb-3">
      Chambres :
    </h4>

    <div class="form-group row string required venue_bedrooms_count"
         :class="formGroupClass(venueFormItem, 'bedroomsCount')">

      <label class="string required col-sm-5 col-form-label text-nowrap"
             for="venue_bedrooms_count">

        Nombre de chambres <abbr title="obligatoire">*</abbr>
      </label>

      <div class="col-sm-3">
        <input :value="venueFormItem.bedroomsCount"
                class="form-control string required"
                :class="inputClass(venueFormItem, 'bedroomsCount')"
                required="required"
                aria-required="true"
                min="0"
                type="number"
                name="venue[bedrooms_count]"
                id="venue_bedrooms_count"
                :aria-invalid="!attributeIsValid(venueFormItem, 'bedroomsCount')">

        <div v-for="(bedroomsCountError, errorIndex) in venueFormItem.errors['bedroomsCount']"
             :key="errorIndex"
             class="invalid-feedback">

          {{ bedroomsCountError }}
        </div>
      </div>
    </div>

    <div class="form-group row string required venue_single_beds_count"
         :class="formGroupClass(venueFormItem, 'singleBedsCount')">
      <label class="string required col-sm-5 col-form-label text-nowrap"
             for="venue_single_beds_count">

        Nombre de lits simples <abbr title="obligatoire">*</abbr>
      </label>

      <div class="col-sm-3">
        <input :value="venueFormItem.singleBedsCount"
                class="form-control string required"
                :class="inputClass(venueFormItem, 'singleBedsCount')"
                required="required"
                aria-required="true"
                min="0"
                type="number"
                name="venue[single_beds_count]"
                id="venue_single_beds_count"
                :aria-invalid="!attributeIsValid(venueFormItem, 'singleBedsCount')">

        <div v-for="(singleBedsCountError, errorIndex) in venueFormItem.errors['singleBedsCount']"
             :key="errorIndex"
             class="invalid-feedback">

          {{ singleBedsCountError }}
        </div>
      </div>
    </div>

    <div class="form-group row string required venue_double_beds_count"
         :class="formGroupClass(venueFormItem, 'doubleBedsCount')">

      <label class="string required col-sm-5 col-form-label text-nowrap"
             for="venue_double_beds_count">

        Nombre de lits doubles <abbr title="obligatoire">*</abbr>
      </label>

      <div class="col-sm-3">
        <input :value="venueFormItem.doubleBedsCount"
                class="form-control string required"
                :class="inputClass(venueFormItem, 'doubleBedsCount')"
                required="required"
                aria-required="true"
                min="0"
                type="number"
                name="venue[double_beds_count]"
                id="venue_double_beds_count"
                :aria-invalid="!attributeIsValid(venueFormItem, 'doubleBedsCount')">

        <div v-for="(doubleBedsCountError, errorIndex) in venueFormItem.errors['doubleBedsCount']"
             :key="errorIndex"
             class="invalid-feedback">

          {{ doubleBedsCountError }}
        </div>
      </div>
    </div>

    <div class="form-group row string required venue_baby_beds_count"
         :class="formGroupClass(venueFormItem, 'babyBedsCount')">

      <label class="string required col-sm-5 col-form-label text-nowrap"
             for="venue_baby_beds_count">

        Nombre de lits bébés <abbr title="obligatoire">*</abbr>
      </label>

      <div class="col-sm-3">
        <input :value="venueFormItem.babyBedsCount"
                class="form-control string required"
                :class="inputClass(venueFormItem, 'babyBedsCount')"
                required="required"
                aria-required="true"
                min="0"
                type="number"
                name="venue[baby_beds_count]"
                id="venue_baby_beds_count"
                :aria-invalid="!attributeIsValid(venueFormItem, 'babyBedsCount')">

        <div v-for="(babyBedsCountError, errorIndex) in venueFormItem.errors['babyBedsCount']"
             :key="errorIndex"
             class="invalid-feedback">

          {{ babyBedsCountError }}
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import formMixin from 'shared/mixins/form_mixin'
  import { mapGetters } from 'vuex'

  export default {
    name: 'VenueBedroomForm',
    mixins: [formMixin],
    computed: {
      ...mapGetters(['venueFormItem'])
    }
  }
</script>
