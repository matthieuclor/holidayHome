<template>
  <div v-show="!bedroom.Destroy">
    <div class="shadow p-3 rounded mb-3">
      <div class="form-group hidden venue_bedrooms_id">
        <input type="hidden"
               :value="bedroom.id"
               :name="`venue[bedrooms_attributes][${index}][id]`"
               :id="`venue_bedrooms_attributes_${index}_id`"
               class="form-control hidden">
      </div>

      <div class="form-row">
        <div class="col-6">
          <div class="form-group string required venue_bedrooms_name"
              :class="formGroupClass(bedroom, 'name')">

            <label class="string required" :for="`venue_bedrooms_attributes_${index}_name`">
              Nom <abbr title="obligatoire">*</abbr>
            </label>

            <input :value="bedroom.name"
                   class="form-control string required"
                   :class="inputClass(bedroom, 'name')"
                   required="required"
                   :aria-invalid="!attributeIsValid(bedroom, 'name')"
                   aria-required="true"
                   type="text"
                   :name="`venue[bedrooms_attributes][${index}][name]`"
                   :id="`venue_bedrooms_attributes_${index}_name`"
                   placeholder="Chambre bleu">

            <div v-for="(bedroomError, errorIndex) in bedroom.errors['name']" :key="errorIndex" class="invalid-feedback">
              {{bedroomError}}
            </div>
          </div>
        </div>
        <div class="col-6 d-flex justify-content-end align-items-start">
          <button @click.prevent="removeBedroom(index)" class="btn btn-danger">
            <i class="fas fa-trash"></i>
          </button>
        </div>
      </div>

      <div class="form-row">
        <div class="col" v-for="(bedding, beddingIndex) in bedroom.beddings" :key="beddingIndex">
          <div class="form-group hidden venue_bedrooms_beddings_id">
            <input :value="bedding.id"
                   type="hidden"
                   :name="`venue[bedrooms_attributes][${index}][beddings_attributes][${beddingIndex}][id]`"
                   :id="`venue_bedrooms_attributes_${index}_beddings_attributes_${beddingIndex}_id`"
                   class="form-control hidden">
          </div>

          <div class="form-group hidden venue_bedrooms_beddings_bed_type">
            <input :value="bedding.bedType"
                   type="hidden"
                   :name="`venue[bedrooms_attributes][${index}][beddings_attributes][${beddingIndex}][bed_type]`"
                   :id="`venue_bedrooms_attributes_${index}_beddings_attributes_${beddingIndex}_bed_type`"
                   class="form-control hidden">
          </div>

          <div class="form-group string required venue_bedrooms_beddings_bed_count">
            <label class="string required"
                  :for="`venue_bedrooms_attributes_${index}_beddings_attributes_${beddingIndex}_bed_count`">
              Nombre de lit {{ bedding.tBedType }} <abbr title="obligatoire">*</abbr>
            </label>

            <input :value="bedding.bedCount"
                   class="form-control string required"
                   required="required"
                   aria-required="true"
                   type="number"
                   :name="`venue[bedrooms_attributes][${index}][beddings_attributes][${beddingIndex}][bed_count]`"
                   :id="`venue_bedrooms_attributes_${index}_beddings_attributes_${beddingIndex}_bed_count`">
          </div>
        </div>
      </div>

      <div class="form-group hidden venue_bedrooms__destroy m-0">
        <input :value="bedroom.Destroy"
               class="form-control hidden"
               type="hidden"
               :name="`venue[bedrooms_attributes][${index}][_destroy]`"
               :id="`venue_bedrooms_attributes_${index}__destroy`">
      </div>
    </div>
  </div>
</template>

<script>
  import formMixin from 'venues/mixins/form_mixin'
  import { mapActions } from 'vuex'

  export default {
    name: 'BedroomListItemForm',
    props: ['bedroom', 'index'],
    mixins: [formMixin],
    methods: {
      ...mapActions([
        'removeBedroom'
      ])
    }
  }
</script>
