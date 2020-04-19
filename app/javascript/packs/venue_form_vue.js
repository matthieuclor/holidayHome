import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'

Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  let element = document.getElementById('venue_form')

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
            this.venue[`${object}s`][index]._destroy = "1"
          }
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
      }
    })
  }
})
