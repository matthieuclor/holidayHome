<template>
  <div>
    <div class="d-flex justify-content-between mb-3">
      <h4 class="d-flex align-items-center">
        Services à domicile :
        <span v-show="venueFormItem.withHomeService" class="badge badge-secondary ml-2">
          {{countObject(venueFormItem.homeServices)}}
        </span>
      </h4>

      <fieldset class="form-group boolean venue_with_home_service mb-2">
        <div class="custom-control custom-switch">
          <input :value="venueFormItem.withHomeService"
                 name="venue[with_home_service]"
                 type="hidden">

          <input :value="venueFormItem.withHomeService"
                 :checked="venueFormItem.withHomeService"
                 @click="venueFormItem.withHomeService = !venueFormItem.withHomeService"
                 type="checkbox"
                 name="venue[with_home_service]"
                 id="venue_with_home_service"
                 class="custom-control-input boolean mb-2">

          <label for="venue_with_home_service" class="custom-control-label boolean">
            Avec un service à domicile
          </label>
        </div>
      </fieldset>
    </div>

    <div v-show="venueFormItem.withHomeService">
      <HomeServiceListItemForm v-for="(homeService, index) in homeServices"
                               :key="index"
                               :homeService="homeService"
                               :index="index" />

      <button @click.prevent="addHomeService" class="btn btn-primary">
        <i class="fas fa-plus mr-2"></i>
        Ajouter un service à domicile
      </button>
    </div>
  </div>
</template>

<script>
  import formMixin from 'shared/mixins/form_mixin'
  import HomeServiceListItemForm from './home_service_list_item_form'
  import { mapGetters, mapActions } from 'vuex'

  export default {
    name: 'HomeServiceListForm',
    props: ['homeServices'],
    mixins: [formMixin],
    components: {
      HomeServiceListItemForm
    },
    computed: {
      ...mapGetters(['venueFormItem'])
    },
    methods: {
      ...mapActions(['addHomeService'])
    }
  }
</script>
