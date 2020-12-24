<template>
  <div v-show="!homeService.Destroy">
    <div class="shadow p-3 rounded mb-3">
      <div class="d-flex justify-content-end">
        <i @click.prevent="removeHomeService(index)"
           class="fas fa-trash text-danger p-2 cursor-pointer">
        </i>
      </div>

      <div class="form-group hidden venue_home_services_id m-0">
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
                   placeholder="Jardinier"
                   :aria-invalid="!attributeIsValid(homeService, 'name')">

            <div v-for="(nameError, errorIndex) in homeService.errors['name']"
                 :key="errorIndex"
                 class="invalid-feedback">

              {{ nameError }}
            </div>
          </div>
        </div>

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
                   placeholder="Jean Dujardin"
                   :aria-invalid="!attributeIsValid(homeService, 'personInCharge')">

            <div v-for="(personInChargeError, errorIndex) in homeService.errors['personInCharge']"
                 :key="errorIndex"
                 class="invalid-feedback">

              {{ personInChargeError }}
            </div>
          </div>
        </div>
      </div>

      <div class="form-row">
        <div class="col-12">
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
                   placeholder="23 Rue Des Plantes"
                   :aria-invalid="!attributeIsValid(homeService, 'address')">

            <div v-for="(addressError, errorIndex) in homeService.errors['address']"
                 :key="errorIndex"
                 class="invalid-feedback">

              {{ addressError }}
            </div>
          </div>
        </div>
      </div>

      <div class="form-row">
        <div class="col-12">
          <div class="form-group string venue_home_services_phone"
               :class="formGroupClass(homeService, 'phone')">

            <label class="string" :for="`venue_home_services_attributes_${index}_phone`">
              Téléphone
            </label>

            <VueTelInput v-model="homeServicePhone" v-bind="phoneProps(index)" />

            <div v-for="(phoneError, errorIndex) in homeService.errors['phone']"
                 :key="errorIndex"
                 class="invalid-feedback">

              {{ phoneError }}
            </div>
          </div>
        </div>
      </div>

      <div class="form-row">
        <div class="col-12">
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
                   placeholder="jeandujardin@mail.com"
                   :aria-invalid="!attributeIsValid(homeService, 'email')">

            <div v-for="(emailError, errorIndex) in homeService.errors['email']"
                 :key="errorIndex"
                 class="invalid-feedback">

              {{ emailError }}
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
import { VueTelInput } from 'vue-tel-input';
import formMixin from 'shared/mixins/form_mixin';
import { mapActions } from 'vuex';

export default {
  name: 'HomeServiceListItemForm',
  props: ['homeService', 'index'],
  data() {
    return {
      homeServicePhone: this.homeService.phone,
    };
  },
  mixins: [formMixin],
  components: {
    VueTelInput,
  },
  methods: {
    ...mapActions(['removeHomeService']),
    phoneProps(index) {
      return {
        mode: 'international',
        defaultCountry: 'FR',
        placeholder: '06 66 76 45 45',
        name: `venue[home_services_attributes][${index}][phone]`,
        inputId: `venue_home_services_attributes_${index}_phone`,
        inputClasses: `form-control string ${this.inputClass(this.homeService, 'phone')}`,
      };
    },
  },
};
</script>

<style lang="scss" scoped>
  .vue-tel-input {
    border-radius: .3125rem;
    border: 0px solid #E6E6E6;
    background-color: #F2F2F2;
  }
</style>
