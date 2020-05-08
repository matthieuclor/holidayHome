<template>
  <div>
    <h4 class="d-flex align-items-center mb-3">
      Salle de bain :
    </h4>

    <div class="form-group row string required venue_bathrooms_count">
      <label class="string required col-sm-5 col-form-label text-nowrap"
             for="venue_bathrooms_count">

        Nombre de salles de bains <abbr title="obligatoire">*</abbr>
      </label>

      <div class="col-sm-3">
        <input :value="venueFormItem.bathroomsCount"
                class="form-control string required"
                required="required"
                aria-required="true"
                type="number"
                name="venue[bathrooms_count]"
                id="venue_bathrooms_count">
      </div>
    </div>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    name: 'VenueBathroomForm',
    computed: {
      ...mapGetters(['venueFormItem'])
    }
  }
</script>
