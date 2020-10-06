<template>
  <div>
    <fieldset class="form-group boolean venue_with_network mb-3">
      <div class="custom-control custom-switch">
        <input :value="venueFormItem.withNetwork" name="venue[with_network]" type="hidden">

        <input :value="venueFormItem.withNetwork"
                :checked="venueFormItem.withNetwork"
                @click="venueFormItem.withNetwork = !venueFormItem.withNetwork"
                type="checkbox"
                name="venue[with_network]"
                id="venue_with_network"
                class="custom-control-input boolean">

        <label for="venue_with_network" class="custom-control-label boolean">
          <h4 class="m-0">
            Réseaux :
            <span v-show="venueFormItem.withNetwork" class="badge badge-secondary ml-2">
              {{ countObject(networks) }}
            </span>
          </h4>
        </label>
      </div>
    </fieldset>

    <div v-show="venueFormItem.withNetwork">
      <NetworkListItemForm v-for="(network, index) in networks"
                           :key="index"
                           :network="network"
                           :index="index" />

      <button @click.prevent="addNetwork" class="btn btn-primary">
        <i class="fas fa-plus mr-2"></i>
        Ajouter une réseau
      </button>
    </div>
  </div>
</template>

<script>
  import formMixin from 'shared/mixins/form_mixin'
  import NetworkListItemForm from './network_list_item_form'
  import { mapGetters, mapActions } from 'vuex'

  export default {
    name: 'NetworkListForm',
    props: ['networks'],
    mixins: [formMixin],
    components: {
      NetworkListItemForm
    },
    computed: {
      ...mapGetters([
        'venueFormItem'
      ])
    },
    methods: {
      ...mapActions([
        'addNetwork'
      ])
    }
  }
</script>
