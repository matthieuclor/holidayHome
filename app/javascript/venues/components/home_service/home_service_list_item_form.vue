<template>
  <div v-show="!homeService.Destroy">
    <div class="shadow p-3 rounded mb-3">
      <div class="form-group hidden venue_home_services_id">
        <input :value="homeService.id"
               type="hidden"
               :name="`venue[home_services_attributes][${index}][id]`"
               :id="`venue_home_services_attributes_${index}_id`"
               class="form-control hidden">
      </div>

      <div class="form-row">
        <div class="col-6">
          <div class="form-group string required venue_home_services_name"
               :class="formGroupClass(homeService, 'name')">

            <label class="string required"
                   :for="`venue_home_services_attributes_${index}_name`">

              Nom <abbr title="obligatoire">*</abbr>
            </label>

            <input :value="homeService.name"
                   class="form-control string required"
                   :class="inputClass(homeService, 'name')"
                   aria-required="true"
                   type="text"
                   :name="`venue[home_services_attributes][${index}][name]`"
                   :id="`venue_home_services_attributes_${index}_name`"
                   placeholder="Jardinier">

            <div v-for="(homeServiceError, errorIndex) in homeService.errors['name']"
                 :key="errorIndex"
                 class="invalid-feedback">

              {{homeServiceError}}
            </div>
          </div>
        </div>

        <div class="col-6 d-flex justify-content-end align-items-start">
          <button @click.prevent="removeHomeService(index)" class="btn btn-danger">
            <i class="fas fa-trash"></i>
          </button>
        </div>
      </div>

      <div class="form-row">
        <div class="col-6">
          <div class="form-group string required venue_home_services_person_in_charge"
               :class="formGroupClass(homeService, 'personInCharge')">

            <label class="string required"
                   :for="`venue_home_services_attributes_${index}_person_in_charge`">

              Responsable <abbr title="obligatoire">*</abbr>
            </label>

            <input :value="homeService.personInCharge"
                   class="form-control string required"
                   :class="inputClass(homeService, 'personInCharge')"
                   aria-required="true"
                   type="text"
                   :name="`venue[home_services_attributes][${index}][person_in_charge]`"
                   :id="`venue_home_services_attributes_${index}_person_in_charge`"
                   placeholder="Jean Dujardin">

            <div v-for="(homeServiceError, errorIndex) in homeService.errors['personInCharge']"
                 :key="errorIndex"
                 class="invalid-feedback">

              {{homeServiceError}}
            </div>
          </div>
        </div>

        <div class="col-6">
          <div class="form-group string venue_home_services_address"
               :class="formGroupClass(homeService, 'address')">

            <label class="string" :for="`venue_home_services_attributes_${index}_address`">
              Adresse
            </label>

            <input :value="homeService.address"
                   class="form-control string"
                   :class="inputClass(homeService, 'address')"
                   type="text"
                   :name="`venue[home_services_attributes][${index}][address]`"
                   :id="`venue_home_services_attributes_${index}_address`"
                   placeholder="23 Rue Des Plantes">

            <div v-for="(homeServiceError, errorIndex) in homeService.errors['address']"
                 :key="errorIndex"
                 class="invalid-feedback">

              {{homeServiceError}}
            </div>
          </div>
        </div>
      </div>

      <div class="form-row d-flex align-items-center">
        <div class="col-4">
          <div class="form-group string venue_home_services_phone"
               :class="formGroupClass(homeService, 'phone')">

            <label class="string" :for="`venue_home_services_attributes_${index}_phone`">
              Téléphone
            </label>

            <input :value="homeService.phone"
                   class="form-control string"
                   :class="inputClass(homeService, 'phone')"
                   type="text"
                   :name="`venue[home_services_attributes][${index}][phone]`"
                   :id="`venue_home_services_attributes_${index}_phone`"
                   placeholder="06 66 76 45 45">

            <div v-for="(homeServiceError, errorIndex) in homeService.errors['phone']"
                 :key="errorIndex"
                 class="invalid-feedback">

              {{homeServiceError}}
            </div>
          </div>
        </div>

        <div class="col-8">
          <div class="form-group string venue_home_services_email"
               :class="formGroupClass(homeService, 'email')">

            <label class="string" :for="`venue_home_services_attributes_${index}_email`">
              Email
            </label>

            <input :value="homeService.email"
                   class="form-control string"
                   :class="inputClass(homeService, 'email')"
                   type="email"
                   :name="`venue[home_services_attributes][${index}][email]`"
                   :id="`venue_home_services_attributes_${index}_email`"
                   placeholder="jeandujardin@mail.com">

            <div v-for="(homeServiceError, errorIndex) in homeService.errors['email']"
                 :key="errorIndex"
                 class="invalid-feedback">

              {{homeServiceError}}
            </div>
          </div>
        </div>
      </div>

      <div class="form-group hidden venue_home_services__destroy m-0">
        <input :value="homeService.Destroy"
               class="form-control hidden"
               type="hidden"
               :name="`venue[home_services_attributes][${index}][_destroy]`"
               :id="`venue_home_services_attributes_${index}__destroy`">
      </div>
    </div>
  </div>
</template>

<script>
  import formMixin from 'venues/mixins/form_mixin'
  import { mapActions } from 'vuex'

  export default {
    name: 'HomeServiceListItemForm',
    props: ['homeService', 'index'],
    mixins: [formMixin],
    methods: {
      ...mapActions([
        'removeHomeService'
      ])
    }
  }
</script>
