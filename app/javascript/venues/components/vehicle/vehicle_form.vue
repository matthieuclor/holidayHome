<template>
  <div>
    <div v-if="vehicleFormItem">
      <div class="d-flex justify-content-between align-items-center">
        <h3 class="m-0">
          {{ (id ? "Editer" : "Créer") + ` un vehicule pour ${vehicleFormItem.venueName}` }}
        </h3>

        <router-link :to="{ name: 'vehicles', params: { venueId: vehicleFormItem.venueId } }">
          <button type="button" class="btn btn-link text-muted ml-2">
            <i class="fas fa-arrow-alt-left fa-2x"></i>
          </button>
        </router-link>
      </div>

      <form @submit.prevent="submitVehicleForm" class="mt-4">
        <div class="form-group hidden vehicle_id form-group-valid">
          <input type="hidden"
                 :value="vehicleFormItem.id"
                 name="vehicle[id]"
                 id="vehicle_id"
                 class="form-control is-valid hidden">
        </div>

        <div class="form-group hidden vehicle_venue_id form-group-valid">
          <input type="hidden"
                 :value="vehicleFormItem.venueId"
                 name="vehicle[venue_id]"
                 id="vehicle_venue_id"
                 class="form-control is-valid hidden">
        </div>

        <div class="form-row">
          <div class="col-5">
            <div class="form-group string required vehicle_vehicle_type"
                 :class="formGroupClass(vehicleFormItem, 'vehicleType')">

              <label class="string required" for="vehicle_vehicle_type">
                Type <abbr title="obligatoire">*</abbr>
              </label>

              <VueAutosuggest :suggestions="suggestions"
                              :input-props="{...inputProps, class: `form-control string required ${inputClass(vehicleFormItem, 'vehicleType')}`}"
                              @input="onInputChange"
                              v-model="vehicleType"
                              @selected="selectHandler">

                <template slot-scope="{suggestion}">
                  <div class="my-suggestion-item text-nowrap text-truncate">
                    <i :class="suggestion.item.iconClass"
                       class="text-muted item-icon">
                    </i>

                    <span v-html="suggestion.item.name"
                          class="item-name">
                    </span>
                  </div>
                </template>
              </VueAutosuggest>

              <div v-for="(vehiclesVehicleTypeError, errorIndex) in vehicleFormItem.errors['vehicleType']"
                   :key="errorIndex"
                   class="invalid-feedback">

                {{ vehiclesVehicleTypeError }}
              </div>
            </div>
          </div>

          <div class="col-7">
            <div class="form-group string required vehicle_name"
                 :class="formGroupClass(vehicleFormItem, 'name')">

              <label class="string required" for="vehicle_name">
                Nom <abbr title="obligatoire">*</abbr>
              </label>

              <input :value="vehicleFormItem.name"
                     class="form-control string required"
                     :class="inputClass(vehicleFormItem, 'name')"
                     required="required"
                     aria-required="true"
                     type="text"
                     name="vehicle[name]"
                     id="vehicle_name"
                     placeholder="Vélo bleu"
                     :aria-invalid="!attributeIsValid(vehicleFormItem, 'name')">

              <div v-for="(vehiclesNameError, errorIndex) in vehicleFormItem.errors['name']"
                   :key="errorIndex"
                   class="invalid-feedback">

                {{ vehiclesNameError }}
              </div>
            </div>
          </div>
        </div>

        <div class="form-row">
          <div class="col-5">
            <div class="form-group select required vehicle_size"
                 :class="formGroupClass(vehicleFormItem, 'size')">

              <label class="select required" for="vehicle_size">
                Taille <abbr title="obligatoire">*</abbr>
              </label>

              <select class="form-control select required"
                      :class="inputClass(vehicleFormItem, 'size')"
                      name="vehicle[size]"
                      id="vehicle_size"
                      :aria-invalid="!attributeIsValid(vehicleFormItem, 'size')">

                <option v-for="(size, sizeIndex) in vehicleFormItem.sizesCollection"
                        :key="sizeIndex"
                        :value="size[1]"
                        :selected="size[1] == vehicleFormItem.size">
                  {{ size[0] }}
                </option>
              </select>

              <div v-for="(vehiclesSizeError, errorIndex) in vehicleFormItem.errors['size']"
                   :key="errorIndex"
                   class="invalid-feedback">

                {{ vehiclesSizeError }}
              </div>
            </div>
          </div>

          <div class="col-7">
            <div class="form-group select required vehicle_condition"
                 :class="formGroupClass(vehicleFormItem, 'condition')">

              <label class="select required" for="vehicle_condition">
                Etat <abbr title="obligatoire">*</abbr>
              </label>

              <select class="form-control select required"
                      :class="inputClass(vehicleFormItem, 'condition')"
                      name="vehicle[condition]"
                      id="vehicle_condition"
                      :aria-invalid="!attributeIsValid(vehicleFormItem, 'condition')">

                <option v-for="(condition, conditionIndex) in vehicleFormItem.conditionsCollection"
                        :key="conditionIndex"
                        :value="condition[1]"
                        :selected="condition[1] == vehicleFormItem.condition">
                  {{ condition[0] }}
                </option>
              </select>

              <div v-for="(vehiclesConditionError, errorIndex) in vehicleFormItem.errors['condition']"
                   :key="errorIndex"
                   class="invalid-feedback">

                {{ vehiclesConditionError }}
              </div>
            </div>
          </div>
        </div>

        <div class="form-group text optional vehicle_comment"
             :class="formGroupClass(vehicleFormItem, 'comment')">

          <label for="vehicle_comment" class="text optional">
            Commentaire
          </label>
          <textarea placeholder="Choses à savoir, précision sur le vehicule..."
                    :value="vehicleFormItem.comment"
                    class="form-control text optional"
                    rows="5"
                    :class="inputClass(vehicleFormItem, 'comment')"
                    name="vehicle[comment]"
                    id="vehicle_comment"
                    :aria-invalid="!attributeIsValid(vehicleFormItem, 'comment')">
          </textarea>

          <div v-for="(vehiclesCommentError, errorIndex) in vehicleFormItem.errors['comment']"
               :key="errorIndex"
               class="invalid-feedback">

            {{ vehiclesCommentError }}
          </div>
        </div>

        <input type="submit"
               :disabled="vehicleFormIsSending"
               name="commit"
               value="Enregistrer"
               class="btn btn-block btn-success">
      </form>
    </div>
    <VenueVehicleFormSkeleton v-else />
  </div>
</template>

<script>
import VenueVehicleFormSkeleton from 'venues/components/skeleton/venue_vehicle_form_skeleton';
import formMixin from 'shared/mixins/form_mixin';
import { VueAutosuggest } from 'vue-autosuggest';
import { mapGetters, mapActions } from 'vuex';
import { debounce } from 'lodash';

export default {
  name: 'VenueForm',
  data() {
    return {
      vehicleFormIsSending: false,
      vehicleType: '',
      suggestions: [],
      inputProps: {
        placeholder: 'Vélo',
        name: 'vehicle[vehicle_type]',
        id: 'vehicle_vehicle_type',
        'aria-required': 'true',
        'aria-invalid': 'false',
        required: 'required',
        autocomplete: 'off',
      },
    };
  },
  props: [
    'venueId',
    'id',
  ],
  mixins: [formMixin],
  components: {
    VenueVehicleFormSkeleton,
    VueAutosuggest,
  },
  computed: {
    ...mapGetters(['vehicleFormItem']),
  },
  methods: {
    ...mapActions([
      'getVehicleFormItem',
      'getVehicleTypeSuggestions',
      'sendVehicleForm',
    ]),
    // eslint-disable-next-line func-names
    onInputChange: debounce(function () {
      if (this.vehicleType.length > 0) {
        this.getVehicleTypeSuggestions(this.vehicleType)
          .then((res) => {
            this.suggestions = [
              {
                data: res.data.vehicleTypes.map((item) => ({
                  name: item.name,
                  iconClass: item.iconClass,
                })),
              },
            ];
          });
      } else {
        this.suggestions = [];
      }
    }, 500),
    selectHandler(e) {
      this.suggestions = [];
      this.vehicleType = e.item.name;
    },
    submitVehicleForm({ target }) {
      this.vehicleFormIsSending = true;

      this.sendVehicleForm(new FormData(target))
        .then((response) => {
          this.$router.push({
            name: 'vehicles',
            params: { venueId: response.data.vehicle.venueId },
          });
        }).catch(
          () => this.scrollToFirstError(),
        ).then(
          () => { this.vehicleFormIsSending = false; },
        );
    },
  },
  watch: {
    id: {
      handler() {
        this.getVehicleFormItem({ venueId: this.venueId, id: this.id });
      },
      immediate: true,
    },
    vehicleFormItem: {
      handler() {
        this.vehicleType = this.vehicleFormItem?.vehicleType;
      },
      immediate: true,
    },
  },
};
</script>
