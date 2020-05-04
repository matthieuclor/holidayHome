<template>
  <div>
    <h4 class="d-flex align-items-center mb-3">
      Salle de bain :
      <span class="badge badge-secondary ml-2">
        {{ countObject(bathrooms) }}
      </span>
    </h4>

    <BathroomListItemForm v-for="(bathroom, index) in bathrooms"
                         :key="index"
                         :bathroom="bathroom"
                         :index="index" />

    <button @click.prevent="addBathroom" class="btn btn-primary">
      <i class="fas fa-plus mr-2"></i>
      Ajouter une salle de bain
    </button>
  </div>
</template>

<script>
  import formMixin from 'venues/mixins/form_mixin'
  import BathroomListItemForm from './bathroom_list_item_form'
  import { mapActions } from 'vuex'

  export default {
    name: 'BathroomListForm',
    props: ['bathrooms'],
    mixins: [formMixin],
    components: {
      BathroomListItemForm
    },
    methods: {
      ...mapActions([
        'addBathroom'
      ])
    }
  }
</script>
