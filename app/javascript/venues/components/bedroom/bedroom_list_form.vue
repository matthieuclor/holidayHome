<template>
  <div>
    <h4 class="d-flex align-items-center mb-3">
      Chambres :
      <span class="badge badge-secondary ml-2">
        {{ countObject(bedrooms) }}
      </span>
    </h4>

    <BedroomListItemForm v-for="(bedroom, index) in bedrooms"
                         :key="index"
                         :bedroom="bedroom"
                         :index="index" />

    <button @click.prevent="addBedroom" class="btn btn-primary">
      <i class="fas fa-plus mr-2"></i>
      Ajouter une chambre
    </button>
  </div>
</template>

<script>
  import formMixin from 'venues/mixins/form_mixin'
  import BedroomListItemForm from './bedroom_list_item_form'
  import { mapActions } from 'vuex'

  export default {
    name: 'BedroomListForm',
    props: ['bedrooms'],
    mixins: [formMixin],
    components: {
      BedroomListItemForm
    },
    methods: {
      ...mapActions([
        'addBedroom'
      ])
    }
  }
</script>
