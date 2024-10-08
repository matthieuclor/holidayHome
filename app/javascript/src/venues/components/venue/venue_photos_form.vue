<template>
  <div>
    <h4 class="d-flex align-items-center mb-3">
      Photos :
    </h4>

    <div v-if="venueId" class="d-flex flex-wrap mt-3">
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

    <div class="form-group file optional venue_photos"
         :class="formGroupClass(venueForm, 'photos')">

      <div class="custom-file">
        <input @change="sendImages"
               class="custom-file-input file optional"
               :class="inputClass(venueForm, 'photos')"
               multiple="multiple"
               type="file"
               lang="fr"
               accept="image/png|image/jpg|image/jpeg"
               :name="venueId ? '' : 'venue[photos][]'"
               :id="venueId ? '' : 'venue_photos'"
               :aria-invalid="!attributeIsValid(venueForm, 'photos')">

        <label class="custom-file-label file optional"
               :for="venueId ? '' : 'venue_photos'"
               ref="CustomFileLabel">
          Choisir des photos
        </label>
      </div>

      <div v-for="(photosError, errorIndex) in venueForm.errors['photos']"
           :key="errorIndex"
           class="invalid-feedback">

        {{ photosError }}
      </div>

      <small class="form-text text-muted">
        Les formats acceptés: png, jpg, jpeg.
        <br>
        La taille d'une photo est limitée à 2mo.
        <br>
        Le nombre total de fichiers est limité à {{ venueForm.photoLimit }}.
      </small>
    </div>
  </div>
</template>

<script>
import bsCustomFileInput from 'bs-custom-file-input';
import formMixin from 'shared/mixins/form_mixin';
import { mapActions } from 'vuex';

export default {
  name: 'VenuePhotosForm',
  props: ['venueForm', 'venueId'],
  mixins: [formMixin],
  methods: {
    ...mapActions([
      'sendVenuePhotosForm',
      'removePhoto',
    ]),
    sendImages(e) {
      if (!this.venueId) return;
      const formData = new FormData();

      Array.from(e.target.files).forEach(
        (file) => formData.append('venue[photos][]', file),
      );

      this.sendVenuePhotosForm({ id: this.venueId, formData })
        .then(() => {
          // eslint-disable-next-line no-param-reassign
          e.target.value = '';
          this.$refs.CustomFileLabel.innerHTML = 'Choisir des photos';
        });
    },
    destroyVenuePhoto(index, id) {
      if (window.confirm('Êtes-vous sûr de vouloir supprimer cette photo ?')) {
        this.removePhoto({ index, venueId: this.venueId, id });
      }
    },
  },
  mounted() {
    bsCustomFileInput.init();
  },
};
</script>
