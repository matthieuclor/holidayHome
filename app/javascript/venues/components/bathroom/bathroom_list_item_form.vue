<template>
  <div v-show="!bathroom.Destroy">
    <div class="shadow p-3 rounded mb-3">
      <div class="form-group hidden venue_bathrooms_id">
        <input :value="bathroom.id"
               type="hidden"
               :name="`venue[bathrooms_attributes][${index}][id]`"
               :id="`venue_bathrooms_attributes_${index}_id`"
               class="form-control hidden">
      </div>

      <div class="form-row">
        <div class="col-6">
          <div class="form-group string required venue_bathrooms_name"
               :class="formGroupClass(bathroom, 'name')">

            <label class="string required" :for="`venue_bathrooms_attributes_${index}_name`">
              Nom <abbr title="obligatoire">*</abbr>
            </label>

            <input :value="bathroom.name"
                   class="form-control string required"
                   :class="inputClass(bathroom, 'name')"
                   required="required"
                   aria-required="true"
                   type="text"
                   :name="`venue[bathrooms_attributes][${index}][name]`"
                   :id="`venue_bathrooms_attributes_${index}_name`"
                   placeholder="Salle de bain d'été">

            <div v-for="(bathroomError, indexError) in bathroom.errors['name']"
                 :key="indexError"
                 class="invalid-feedback">

              {{bathroomError}}
            </div>
          </div>
        </div>

        <div class="col-6 d-flex justify-content-end align-items-start">
          <button @click.prevent="removeBathroom(index)" class="btn btn-danger">
            <i class="fas fa-trash"></i>
          </button>
        </div>
      </div>

      <div class="form-group hidden venue_bathrooms__destroy m-0">
        <input :value="bathroom.Destroy"
               class="form-control hidden"
               type="hidden"
               :name="`venue[bathrooms_attributes][${index}][_destroy]`"
               :id="`venue_bathrooms_attributes_${index}__destroy`">
      </div>
    </div>
  </div>
</template>

<script>
  import formMixin from 'venues/mixins/form_mixin'
  import { mapActions } from 'vuex'

  export default {
    name: 'BathroomListItemForm',
    props: ['bathroom', 'index'],
    mixins: [formMixin],
    methods: {
      ...mapActions([
        'removeBathroom'
      ])
    }
  }
</script>
