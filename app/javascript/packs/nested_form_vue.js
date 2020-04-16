import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'

Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  document.querySelectorAll('.nested_form').forEach(element => {
    let nestedObjects = JSON.parse(element.dataset.nestedObjects)
    let newNestedObject = JSON.parse(element.dataset.newNestedObject)

    nestedObjects.forEach(object => object._destroy = null)
    newNestedObject._destroy = null

    new Vue({
      el: element,
      data: () => {
        return {
          nestedObjects: nestedObjects,
          newNestedObject: newNestedObject,
        }
      },
      methods: {
        addNestedForm: function() {
          this.nestedObjects.push(this.newNestedObject)
        },
        removeNestedForm: function(index) {
          if (this.nestedObjects[index].id == null) {
            this.nestedObjects.splice(index, 1)
          } else {
            this.nestedObjects[index]._destroy = "1"
          }
        },
      }
    })
  })
})
