<template>
  <div>
    <div class="d-flex justify-content-between mb-3">
      <h4 class="d-flex align-items-center">
        Digicodes :
        <span v-show="venueFormItem.withDigitalCode" class="badge badge-secondary ml-2">
          {{countObject(digitalCodes)}}
        </span>
      </h4>

      <fieldset class="form-group boolean venue_with_digital_code mb-2">
        <div class="custom-control custom-switch">
          <input :value="venueFormItem.withDigitalCode"
                 name="venue[with_digital_code]"
                 type="hidden">

          <input :value="venueFormItem.withDigitalCode"
                 :checked="venueFormItem.withDigitalCode"
                 @click="venueFormItem.withDigitalCode = !venueFormItem.withDigitalCode"
                 class="custom-control-input boolean"
                 id="venue_with_digital_code"
                 type="checkbox"
                 name="venue[with_digital_code]">

          <label for="venue_with_digital_code" class="custom-control-label boolean">
            Avec un digicode
          </label>
        </div>
      </fieldset>
    </div>

    <div v-show="venueFormItem.withDigitalCode">
      <DigitalCodeListItemForm v-for="(digitalCode, index) in digitalCodes"
                               :key="index"
                               :digitalCode="digitalCode"
                               :index="index" />

      <button @click.prevent="addDigitalCode" class="btn btn-primary">
        <i class="fas fa-plus mr-2"></i>
        Ajouter une digicode
      </button>
    </div>
  </div>
</template>

<script>
  import formMixin from 'venues/mixins/form_mixin'
  import DigitalCodeListItemForm from './digital_code_list_item_form'
  import { mapGetters, mapActions } from 'vuex'

  export default {
    name: 'DigitalCodeListForm',
    props: ['digitalCodes'],
    mixins: [formMixin],
    components: {
      DigitalCodeListItemForm
    },
    computed: {
      ...mapGetters([
        'venueFormItem'
      ])
    },
    methods: {
      ...mapActions([
        'addDigitalCode'
      ])
    }
  }
</script>
