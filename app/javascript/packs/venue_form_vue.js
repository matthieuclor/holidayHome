import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'
import places from 'places.js'

Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  const element = document.getElementById('venue_form')

  if (element != null) {
    new Vue({
      el: element,
      data: () => {
        return {
          formIsEditing: element.dataset.formIsEditing,
          venue: JSON.parse(element.dataset.venue),
          newBedroom: JSON.parse(element.dataset.newBedroom),
          newBathroom: JSON.parse(element.dataset.newBathroom),
          newKey: JSON.parse(element.dataset.newKey),
          newNetwork: JSON.parse(element.dataset.newNetwork),
          newDigitalCode: JSON.parse(element.dataset.newDigitalCode),
          newHomeService: JSON.parse(element.dataset.newHomeService),
        }
      },
      methods: {
        addObject: function(object) {
          this.venue[`${object}s`].push(
            JSON.parse(
              JSON.stringify(
                this[`new${object.charAt(0).toUpperCase() + object.slice(1)}`]
              )
            )
          )
        },
        removeObject: function(object, index) {
          if (this.venue[`${object}s`][index].id == null) {
            this.venue[`${object}s`].splice(index, 1)
          } else {
            this.venue[`${object}s`][index].Destroy = true
          }
        },
        countObject: function(objects) {
          return objects.filter(object => object.Destroy != true).length
        },
        attributeIsValid: function(object, attribute) {
          return !(attribute in object.errors)
        },
        inputClass: function(object, attribute) {
          if (!this.attributeIsValid(object, attribute)) {
            return 'is-invalid'
          } else if (this.formIsEditing == "true" && object[attribute]) {
            return 'is-valid'
          }
        },
        formGroupClass: function(object, attribute) {
          if (!this.attributeIsValid(object, attribute)) {
            return 'form-group-invalid'
          } else if (this.formIsEditing == "true" && object[attribute]) {
            return 'form-group-valid'
          }
        }
      },
      mounted: function () {
        this.$nextTick(function () {
          const options = {
            appId: 'pl75UUU9N2VV',
            apiKey: '9a55decbc8fd5c78a1d571f4143fef56',
            container: this.$refs.inputSearch,
          }

          const place = places(options).configure({ language: 'fr' })

          place.on('change', event => {
            this.venue.address = event.suggestion.value
            this.venue.city = event.suggestion.name
            this.venue.postcode = event.suggestion.postcode
            this.venue.country = event.suggestion.country
            this.venue.countryCode = event.suggestion.countryCode
            this.venue.administrative = event.suggestion.administrative
            this.venue.county = event.suggestion.county
            this.venue.lat = event.suggestion.latlng.lat
            this.venue.lng = event.suggestion.latlng.lng
          })
        })
      },
      beforeDestroy: () => place.destroy()
    })
  }
})
