<template>
  <div v-show="!digitalCode.Destroy">
    <div class="shadow p-3 rounded mb-3">
      <div class="d-flex justify-content-end">
        <i @click.prevent="removeDigitalCode(index)"
           class="fas fa-trash text-danger p-2 cursor-pointer">
        </i>
      </div>

      <div class="form-group hidden venue_digital_codes_id m-0">
        <input :value="digitalCode.id"
               type="hidden"
               :name="`venue[digital_codes_attributes][${index}][id]`"
               :id="`venue_digital_codes_attributes_${index}_id`"
               class="form-control hidden">
      </div>

      <div class="form-row">
        <div class="col-6">
          <div class="form-group string required venue_digital_codes_name"
               :class="formGroupClass(digitalCode, 'name')">

            <label class="string required"
                   :for="`venue_digital_codes_attributes_${index}_name`">

              Nom <abbr title="obligatoire">*</abbr>
            </label>

            <input :value="digitalCode.name"
                   class="form-control string required"
                   :class="inputClass(digitalCode, 'name')"
                   aria-required="true"
                   type="text"
                   :name="`venue[digital_codes_attributes][${index}][name]`"
                   :id="`venue_digital_codes_attributes_${index}_name`"
                   placeholder="Porte du premier bâtiment"
                   :aria-invalid="!attributeIsValid(digitalCode, 'name')">

            <div v-for="(digitalCodeError, errorIndex) in digitalCode.errors['name']"
                 :key="errorIndex"
                 class="invalid-feedback">

              {{ digitalCodeError }}
            </div>
          </div>
        </div>

        <div class="col-6">
          <div class="form-group string required venue_digital_codes_password"
               :class="formGroupClass(digitalCode, 'password')">

            <label class="string required"
                   :for="`venue_digital_codes_attributes_${index}_password`">

              Mot de passe <abbr title="obligatoire">*</abbr>
            </label>

            <input :value="digitalCode.password"
                   class="form-control string required"
                   :class="inputClass(digitalCode, 'password')"
                   aria-required="true"
                   type="text"
                   :name="`venue[digital_codes_attributes][${index}][password]`"
                   :id="`venue_digital_codes_attributes_${index}_password`"
                   placeholder="Mot de passe"
                   :aria-invalid="!attributeIsValid(digitalCode, 'password')">

            <div v-for="(digitalCodeError, errorIndex) in digitalCode.errors['password']"
                 :key="errorIndex"
                 class="invalid-feedback">

              {{ digitalCodeError }}
            </div>
          </div>
        </div>
      </div>

      <div class="form-group hidden venue_digital_codes__destroy m-0">
        <input :value="digitalCode.Destroy"
               class="form-control hidden"
               type="hidden"
               :name="`venue[digital_codes_attributes][${index}][_destroy]`"
               :id="`venue_digital_codes_attributes_${index}__destroy`">
      </div>
    </div>
  </div>
</template>

<script>
import formMixin from 'shared/mixins/form_mixin';
import { mapActions } from 'vuex';

export default {
  name: 'DigitalCodeListItemForm',
  props: ['digitalCode', 'index'],
  mixins: [formMixin],
  methods: {
    ...mapActions(['removeDigitalCode']),
  },
};
</script>
