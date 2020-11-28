<template>
  <div v-show="!keyItem.Destroy">
    <div class="shadow p-3 rounded mb-3">
      <div class="d-flex justify-content-end">
        <i @click.prevent="removeKey(index)"
           class="fas fa-trash text-danger p-2 cursor-pointer">
        </i>
      </div>

      <div class="form-group hidden venue_keys_id m-0">
        <input :value="keyItem.id"
               type="hidden"
               :name="`venue[keys_attributes][${index}][id]`"
               :id="`venue_keys_attributes_${index}_id`"
               class="form-control hidden">
      </div>

      <div class="form-row">
        <div class="col-7">
          <div class="form-group string required venue_keys_name"
               :class="formGroupClass(keyItem, 'name')">

            <label class="string required" :for="`venue_keys_attributes_${index}_name`">
              Nom <abbr title="obligatoire">*</abbr>
            </label>

            <input :value="keyItem.name"
                   class="form-control string required"
                   :class="inputClass(keyItem, 'name')"
                   required="required"
                   aria-required="true"
                   type="text"
                   :name="`venue[keys_attributes][${index}][name]`"
                   :id="`venue_keys_attributes_${index}_name`"
                   placeholder="Clé principale"
                   :aria-invalid="!attributeIsValid(keyItem, 'name')">

            <div v-for="(keyError, errorIndex) in keyItem.errors['name']"
                 :key="errorIndex"
                 class="invalid-feedback">

              {{ keyError }}
            </div>
          </div>
        </div>

        <div class="col-5">
          <div class="form-group select required venue_keys_owner_id"
               :class="formGroupClass(keyItem, 'owner')">

            <label class="select required" :for="`venue_keys_attributes_${index}_owner_id`">
              Propriétaire <abbr title="obligatoire">*</abbr>
            </label>

            <select class="form-control select required"
                    :class="inputClass(keyItem, 'owner')"
                    :name="`venue[keys_attributes][${index}][owner_id]`"
                    :id="`venue_keys_attributes_${index}_owner_id`"
                    :aria-invalid="!attributeIsValid(keyItem, 'owner')">

              <option v-for="(owner, ownerIndex) in venueOwnerFormItems"
                      :key="ownerIndex"
                      :value="owner.id"
                      :selected="owner.id == keyItem.ownerId">

                {{ owner.fullName }}
              </option>
            </select>

            <div v-for="(keyError, errorIndex) in keyItem.errors['owner']"
                 :key="errorIndex"
                 class="invalid-feedback">

              {{ keyError }}
            </div>
          </div>
        </div>
      </div>

      <div class="form-group hidden venue_keys__destroy m-0">
        <input :value="keyItem.Destroy"
               class="form-control hidden"
               type="hidden"
               :name="`venue[keys_attributes][${index}][_destroy]`"
               :id="`venue_keys_attributes_${index}__destroy`">
      </div>
    </div>
  </div>
</template>

<script>
import formMixin from 'shared/mixins/form_mixin';
import { mapGetters, mapActions } from 'vuex';

export default {
  name: 'KeyListItemForm',
  props: ['keyItem', 'index'],
  mixins: [formMixin],
  computed: {
    ...mapGetters(['venueOwnerFormItems']),
  },
  methods: {
    ...mapActions(['removeKey']),
  },
};
</script>
