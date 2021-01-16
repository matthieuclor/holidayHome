<template>
  <div>
    <h4 class="d-flex align-items-center mb-3">
      Accessoires :
    </h4>

    <div class="form-group row mb-0">
      <div class="col-6">
        <fieldset class="form-group boolean venue_with_washing_machine">
          <div class="custom-control custom-switch">
            <input name="venue[with_washing_machine]"
                   type="hidden"
                   :value="venueFormItem.withWashingMachine">

            <input type="checkbox"
                   :value="venueFormItem.withWashingMachine"
                   :checked="venueFormItem.withWashingMachine"
                   @click="venueFormItem.withWashingMachine = !venueFormItem.withWashingMachine"
                   name="venue[with_washing_machine]"
                   id="venue_with_washing_machine"
                   class="custom-control-input boolean">

            <label for="venue_with_washing_machine"
                   class="custom-control-label boolean">
              Lave-linge
            </label>
          </div>
        </fieldset>
      </div>

      <div class="col-6">
        <fieldset class="form-group boolean venue_with_tumble_dryer mb-0">
          <div class="custom-control custom-switch">
            <input name="venue[with_tumble_dryer]"
                   type="hidden"
                   :value="venueFormItem.withTumbleDryer">

            <input type="checkbox"
                   :value="venueFormItem.withTumbleDryer"
                   :checked="venueFormItem.withTumbleDryer"
                   @click="venueFormItem.withTumbleDryer = !venueFormItem.withTumbleDryer"
                   name="venue[with_tumble_dryer]"
                   id="venue_with_tumble_dryer"
                   class="custom-control-input boolean">

            <label for="venue_with_tumble_dryer"
                   class="custom-control-label boolean">
              Sèche-linge
            </label>
          </div>
        </fieldset>
      </div>
    </div>

    <fieldset class="form-group boolean venue_with_dishwasher">
      <div class="custom-control custom-switch">
        <input name="venue[with_dishwasher]"
               type="hidden"
               :value="venueFormItem.withDishwasher">

        <input type="checkbox"
               :value="venueFormItem.withDishwasher"
               :checked="venueFormItem.withDishwasher"
               @click="venueFormItem.withDishwasher = !venueFormItem.withDishwasher"
               name="venue[with_dishwasher]"
               id="venue_with_dishwasher"
               class="custom-control-input boolean">

        <label for="venue_with_dishwasher"
               class="custom-control-label boolean">
          Lave-vaisselle
        </label>
      </div>
    </fieldset>
  </div>
</template>

<script>
import formMixin from 'shared/mixins/form_mixin';
import { mapGetters } from 'vuex';

export default {
  name: 'VenueAccessoriesForm',
  mixins: [formMixin],
  computed: {
    ...mapGetters(['venueFormItem']),
  },
};
</script>
