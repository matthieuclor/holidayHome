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
          this.venue[`${object}s`].push(this[`new${object.charAt(0).toUpperCase() + object.slice(1)}`])
        },
        removeObject: function(object, index) {
          if (this.venue[`${object}s`][index].id == null) {
            this.venue[`${object}s`].splice(index, 1)
          } else {
            this.venue[`${object}s`][index]._destroy = "1"
          }
        }
      }
    })
  }
})
