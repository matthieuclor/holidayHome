<template>
  <div>
    <h4 class="d-flex align-items-center mb-3">
      Photos :
    </h4>

    <div class="d-flex flex-wrap mt-3">
      <div v-for="(photo, index) in venueForm.photos" :key="index">
        <div class="mr-4 mb-3">
          <img :src="photo.url" class="rounded">
          <button @click.prevent="destroyVenuePhoto(index, photo.id)"
                  class="btn btn-sm btn-danger position-absolute mt-n2 ml-n3">

            <i class="fas fa-trash"></i>
          </button>
        </div>
      </div>
    </div>

    <div class="form-group row file optional venue_photos"
         :class="formGroupClass(venueForm, 'photos')">

      <div class="col-sm-10 d-flex align-items-center">
        <input class="form-control-file file optional"
               :class="inputClass(venueForm, 'photos')"
               multiple="multiple"
               type="file"
               accept="image/png|image/jpg|image/jpeg"
               name="venue[photos][]"
               id="venue_photos">

        <div v-for="(photosError, errorIndex) in venueForm.errors['photos']"
             :key="errorIndex"
             class="invalid-feedback">

          {{ photosError }}
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import formMixin from 'shared/mixins/form_mixin'
  import { mapGetters } from 'vuex'

  export default {
    name: 'VenuePhotosForm',
    props: ['venueForm'],
    mixins: [formMixin]
  }
</script>
