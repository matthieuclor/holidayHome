<template>
  <div v-show="!network.Destroy">
    <div class="shadow p-3 rounded mb-3">
      <div class="form-group hidden venue_networks_id">
        <input :value="network.id"
               type="hidden"
               :name="`venue[networks_attributes][${index}][id]`"
               :id="`venue_networks_attributes_${index}_id`"
               class="form-control hidden">
      </div>

      <div class="form-row">
        <div class="col-5">
          <div class="form-group string required venue_networks_name"
               :class="formGroupClass(network, 'name')">

            <label class="string required"
                   :for="`venue_networks_attributes_${index}_name`">

              Nom du réseau <abbr title="obligatoire">*</abbr>
            </label>

            <input :value="network.name"
                   class="form-control string required"
                   :class="inputClass(network, 'name')"
                   aria-required="true"
                   type="text"
                   :name="`venue[networks_attributes][${index}][name]`"
                   :id="`venue_networks_attributes_${index}_name`"
                   placeholder="Réseau Orange"
                   :aria-invalid="!attributeIsValid(network, 'name')">

            <div v-for="(networkError, errorIndex) in network.errors['name']"
                 :key="errorIndex"
                 class="invalid-feedback">

              {{ networkError }}
            </div>
          </div>
        </div>

        <div class="col-5">
          <div class="form-group string venue_networks_password"
               :class="formGroupClass(network, 'password')">

            <label class="string" :for="`venue_networks_attributes_${index}_password`">
              Mot de passe du réseau
            </label>

            <input :value="network.password"
                   class="form-control string"
                   :class="inputClass(network, 'password')"
                   type="text"
                   :name="`venue[networks_attributes][${index}][password]`"
                   :id="`venue_networks_attributes_${index}_password`"
                   placeholder="Mot de passe"
                   :aria-invalid="!attributeIsValid(network, 'password')">

            <div v-for="(networkError, errorIndex) in network.errors['password']"
                 :key="errorIndex"
                 class="invalid-feedback">

              {{ networkError }}
            </div>
          </div>
        </div>

        <div class="col-2 d-flex justify-content-end align-items-start">
          <button @click.prevent="removeNetwork(index)" class="btn btn-danger">
            <i class="fas fa-trash"></i>
          </button>
        </div>
      </div>

      <div class="form-group hidden venue_networks__destroy m-0">
        <input :value="network.Destroy"
               class="form-control hidden"
               type="hidden"
               :name="`venue[networks_attributes][${index}][_destroy]`"
               :id="`venue_networks_attributes_${index}__destroy`">
      </div>
    </div>
  </div>
</template>

<script>
  import formMixin from 'shared/mixins/form_mixin'
  import { mapActions } from 'vuex'

  export default {
    name: 'NetworkListItemForm',
    props: ['network', 'index'],
    mixins: [formMixin],
    methods: {
      ...mapActions(['removeNetwork'])
    }
  }
</script>
