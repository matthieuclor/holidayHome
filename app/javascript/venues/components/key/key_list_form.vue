<template>
  <div>
    <h4 class="d-flex align-items-center mb-3">
      Clés :
      <span class="badge badge-secondary ml-2">
        {{ countObject(keys) }}
      </span>
    </h4>

    <KeyListItemForm v-for="(key, index) in keys"
                     :key="index"
                     :keyItem="key"
                     :index="index" />

    <button @click.prevent="addKey" class="btn btn-primary">
      <i class="fas fa-plus mr-2"></i>
      Ajouter une clé
    </button>
  </div>
</template>

<script>
  import formMixin from 'shared/mixins/form_mixin'
  import KeyListItemForm from './key_list_item_form'
  import { mapActions } from 'vuex'

  export default {
    name: 'KeyListForm',
    props: ['keys'],
    mixins: [formMixin],
    components: {
      KeyListItemForm
    },
    methods: {
      ...mapActions(['addKey'])
    }
  }
</script>
