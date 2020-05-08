<template>
  <div>
    <div class="form-group row string required venue_name">
      <label for="venue_address" class="string required col-sm-2 col-form-label text-nowrap">
        Adresse <abbr title="obligatoire">*</abbr>
      </label>

      <div class="col-sm-10">
        <input ref="inputSearch"
              :value="venueFormItem.address"
              placeholder="12 Rue de Bellecote"
              required="required"
              aria-required="true"
              type="text"
              name="venue[address]"
              id="venue_address"
              class="form-control string required"
              :class="inputClass(venueFormItem, 'address')"
              :aria-invalid="!attributeIsValid(venueFormItem, 'address')">
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
  import formMixin from 'venues/mixins/form_mixin'
  import { mapGetters } from 'vuex'
  import places from 'places.js'

  export default {
    name: 'VenuePlacesForm',
    data() {
      return {
        place: null,
        language: 'fr',
        options: {
          appId: 'pl75UUU9N2VV',
          apiKey: '9a55decbc8fd5c78a1d571f4143fef56',
          container: null
        }
      }
    },
    computed: {
      ...mapGetters([
        'venueFormItem'
      ]),
    },
    mixins: [formMixin],
    mounted() {
      this.$nextTick(function () {
        this.options.container = this.$refs.inputSearch
        this.place = places(this.options).configure(this.language)
        this.place.on('change', event => {
          this.venueFormItem.address = event.suggestion.value
          this.venueFormItem.city = event.suggestion.name
          this.venueFormItem.postcode = event.suggestion.postcode
          this.venueFormItem.country = event.suggestion.country
          this.venueFormItem.countryCode = event.suggestion.countryCode
          this.venueFormItem.administrative = event.suggestion.administrative
          this.venueFormItem.county = event.suggestion.county
          this.venueFormItem.lat = event.suggestion.latlng.lat
          this.venueFormItem.lng = event.suggestion.latlng.lng
        })
      })
    }
  }
</script>
