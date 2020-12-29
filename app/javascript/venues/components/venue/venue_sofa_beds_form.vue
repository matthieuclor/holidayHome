<template>
  <div>
    <h4 class="d-flex align-items-center mb-3">
      Convertibles :
    </h4>

    <div class="form-group row string required venue_single_sofa_beds_count"
         :class="formGroupClass(venueFormItem, 'singleSofaBedsCount')">

      <label class="string required col-sm-6 col-form-label text-nowrap"
             for="venue_single_sofa_beds_count">
        Nombre de convertible simple <abbr title="obligatoire">*</abbr>
      </label>

      <div class="col-sm-3">
        <input :value="venueFormItem.singleSofaBedsCount"
               class="form-control string required"
               :class="inputClass(venueFormItem, 'singleSofaBedsCount')"
               required="required"
               aria-required="true"
               min="0"
               type="number"
               name="venue[single_sofa_beds_count]"
               id="venue_single_sofa_beds_count"
               :aria-invalid="!attributeIsValid(venueFormItem, 'singleSofaBedsCount')">

        <div v-for="(singleSofaBedsCountError, errorIndex) in venueFormItem.errors['singleSofaBedsCount']"
             :key="errorIndex"
             class="invalid-feedback">

          {{ singleSofaBedsCountError }}
        </div>
      </div>
    </div>

    <div class="form-group row string required venue_double_sofa_beds_count"
         :class="formGroupClass(venueFormItem, 'doubleSofaBedsCount')">

      <label class="string required col-sm-6 col-form-label text-nowrap"
             for="venue_double_sofa_beds_count">
        Nombre de convertible double <abbr title="obligatoire">*</abbr>
      </label>

      <div class="col-sm-3">
        <input :value="venueFormItem.doubleSofaBedsCount"
               class="form-control string required"
               :class="inputClass(venueFormItem, 'doubleSofaBedsCount')"
               required="required"
               aria-required="true"
               min="0"
               type="number"
               name="venue[double_sofa_beds_count]"
               id="venue_double_sofa_beds_count"
               :aria-invalid="!attributeIsValid(venueFormItem, 'doubleSofaBedsCount')">

        <div v-for="(doubleSofaBedsCountError, errorIndex) in venueFormItem.errors['doubleSofaBedsCount']"
             :key="errorIndex"
             class="invalid-feedback">

          {{ doubleSofaBedsCountError }}
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import formMixin from 'shared/mixins/form_mixin';
import { mapGetters } from 'vuex';

export default {
  name: 'VenueSofaBedsForm',
  mixins: [formMixin],
  computed: {
    ...mapGetters(['venueFormItem']),
  },
};
</script>
