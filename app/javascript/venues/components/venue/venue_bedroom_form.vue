<template>
  <div>
    <h4 class="d-flex align-items-center mb-3">
      Chambres :
    </h4>

    <div class="form-group row string required venue_bedrooms_count">
      <label class="string required col-sm-5 col-form-label text-nowrap"
             for="venue_bedrooms_count">

        Nombre de chambres <abbr title="obligatoire">*</abbr>
      </label>

      <div class="col-sm-3">
        <input :value="venueFormItem.bedroomsCount"
                class="form-control string required"
                required="required"
                aria-required="true"
                type="number"
                name="venue[bedrooms_count]"
                id="venue_bedrooms_count">
      </div>
    </div>

    <div class="form-group row string required venue_single_beds_count">
      <label class="string required col-sm-5 col-form-label text-nowrap"
             for="venue_single_beds_count">

        Nombre de lits simples <abbr title="obligatoire">*</abbr>
      </label>

      <div class="col-sm-3">
        <input :value="venueFormItem.singleBedsCount"
                class="form-control string required"
                required="required"
                aria-required="true"
                type="number"
                name="venue[single_beds_count]"
                id="venue_single_beds_count">
      </div>
    </div>

    <div class="form-group row string required venue_double_beds_count">
      <label class="string required col-sm-5 col-form-label text-nowrap"
             for="venue_double_beds_count">

        Nombre de lits doubles <abbr title="obligatoire">*</abbr>
      </label>

      <div class="col-sm-3">
        <input :value="venueFormItem.doubleBedsCount"
                class="form-control string required"
                required="required"
                aria-required="true"
                type="number"
                name="venue[double_beds_count]"
                id="venue_double_beds_count">
      </div>
    </div>

    <div class="form-group row string required venue_baby_beds_count">
      <label class="string required col-sm-5 col-form-label text-nowrap"
             for="venue_baby_beds_count">

        Nombre de lits bébés <abbr title="obligatoire">*</abbr>
      </label>

      <div class="col-sm-3">
        <input :value="venueFormItem.babyBedsCount"
                class="form-control string required"
                required="required"
                aria-required="true"
                type="number"
                name="venue[baby_beds_count]"
                id="venue_baby_beds_count">
      </div>
    </div>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    name: 'VenueBedroomForm',
    computed: {
      ...mapGetters(['venueFormItem'])
    }
  }
</script>
