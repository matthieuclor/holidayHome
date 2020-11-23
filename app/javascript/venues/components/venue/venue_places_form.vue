<template>
  <div>
    <div class="form-group row string required venue_name"
         :class="formGroupClass(venueFormItem, 'address')">

      <label for="venue_address" class="string required col-sm-2 col-form-label text-nowrap">
        Adresse <abbr title="obligatoire">*</abbr>
      </label>

      <div class="col-sm-10">
        <VueAutosuggest :suggestions="suggestions"
                        :input-props="{...inputProps, class: `form-control string required ${inputClass(venueFormItem, 'address')}`}"
                        @input="onInputChange"
                        v-model="address"
                        @selected="selectHandler">

          <template slot-scope="{suggestion}">
            <div class="my-suggestion-item text-nowrap text-truncate">
              <i :class="suggestion.item.iconClass"
                class="text-muted item-icon">
              </i>

              <span v-html="suggestion.item.name"
                    class="item-name">
              </span>

              <span v-html="suggestion.item.address"
                    class="item-address text-muted">
              </span>
            </div>
          </template>
        </VueAutosuggest>
      </div>

      <div v-for="(venueError, errorIndex) in venueFormItem.errors['address']"
           :key="errorIndex"
           class="invalid-feedback d-block">

        {{venueError}}
      </div>
    </div>

    <div class="form-group hidden venue_city">
      <input type="hidden"
             :value="venueFormItem.city"
             name="venue[city]"
             id="venue_city"
             class="form-control hidden">
    </div>

    <div class="form-group hidden venue_postcode">
      <input type="hidden"
             :value="venueFormItem.postcode"
             name="venue[postcode]"
             id="venue_postcode"
             class="form-control hidden">
    </div>

    <div class="form-group hidden venue_country">
      <input type="hidden"
             :value="venueFormItem.country"
             name="venue[country]"
             id="venue_country"
             class="form-control hidden">
    </div>

    <div class="form-group hidden venue_country_code">
      <input type="hidden"
             :value="venueFormItem.countryCode"
             name="venue[country_code]"
             id="venue_country_code"
             class="form-control hidden">
    </div>

    <div class="form-group hidden venue_administrative">
      <input type="hidden"
             :value="venueFormItem.administrative"
             name="venue[administrative]"
             id="venue_administrative"
             class="form-control hidden">
    </div>

    <div class="form-group hidden venue_county">
      <input type="hidden"
             :value="venueFormItem.county"
             name="venue[county]"
             id="venue_county"
             class="form-control hidden">
    </div>

    <div class="form-group hidden venue_lat">
      <input type="hidden"
             :value="venueFormItem.lat"
             name="venue[lat]"
             id="venue_lat"
             class="form-control hidden">
    </div>

    <div class="form-group hidden venue_lng">
      <input type="hidden"
             :value="venueFormItem.lng"
             name="venue[lng]"
             id="venue_lng"
             class="form-control hidden">
    </div>
  </div>
</template>

<script>
  import formMixin from 'shared/mixins/form_mixin'
  import { VueAutosuggest } from 'vue-autosuggest';
  import { mapGetters, mapActions } from 'vuex'
  import { debounce } from 'lodash'

  export default {
    name: 'VenuePlacesForm',
    mixins: [formMixin],
    data() {
      return {
        address: "",
        suggestions: [],
        inputProps: {
          placeholder:'12 Rue de Bellecote',
          name: "venue[address]",
          id: "venue_address",
          'aria-required': "true",
          required: "required",
          autocomplete: "off"
        }
      }
    },
    computed: {
      ...mapGetters(['venueFormItem']),
    },
    components: {
      VueAutosuggest
    },
    methods: {
      ...mapActions(['getAlgoliaPlacesSuggestions']),
      onInputChange: debounce(function() {
        if (this.address.length > 0) {
          this.getAlgoliaPlacesSuggestions(this.address)
          .then(res => {
            this.suggestions = [
              {
                data: res.data.hits.map(item => {
                  return {
                    name: item.name,
                    address: item.address,
                    iconClass: item.iconClass,
                    fullAddress: item.fullAddress,
                    city: item.city,
                    postcode: item.postcode,
                    country: item.country,
                    countryCode: item.countryCode,
                    administrative: item.administrative,
                    county: item.county,
                    lat: item.lat,
                    lng: item.lng
                  }
                })
              }
            ]
          })
        } else {
          this.suggestions = []
        }
      }, 500),
      selectHandler(e) {
        this.suggestions = []
        this.address = e.item.fullAddress
        this.venueFormItem.address = e.item.fullAddress
        this.venueFormItem.city = e.item.city
        this.venueFormItem.postcode = e.item.postcode
        this.venueFormItem.country = e.item.country
        this.venueFormItem.countryCode = e.item.countryCode
        this.venueFormItem.administrative = e.item.administrative
        this.venueFormItem.county = e.item.county
        this.venueFormItem.lat = e.item.lat
        this.venueFormItem.lng = e.item.lng
      }
    },
    watch: {
      venueFormItem: {
        handler() {
          this.address = this.venueFormItem.address
        },
        immediate: true
      }
    }
  }
</script>

<style>
  .autosuggest__results-container {
    margin-top: 3px;
    border-radius: 0.3125rem;
    box-shadow: 0 0 0.625rem rgba(0, 0, 0, 0.15);
  }

  .autosuggest__results > ul {
    list-style: none;
    padding: 0;
  }

  .autosuggest__results-item {
    cursor: pointer;
    height: 46px;
    line-height: 46px;
    padding-left: 18px;
  }

  .autosuggest__results-item:hover {
    background-color: #F2F2F2;
  }

  .autosuggest__results-item:hover .item-icon {
    color: #38b2ac !important;
  }

  .my-suggestion-item > .item-name em {
    font-weight: bold;
    font-style: normal;
  }

  .my-suggestion-item > .item-address em {
    font-weight: bold;
    font-style: normal;
  }

  .my-suggestion-item > .item-address {
    font-size: smaller;
    margin-left: 12px;
  }

  .item-icon {
    margin-right: 10px;
    font-size: 18px;
    width: 20px;
    text-align: center;
  }
</style>
