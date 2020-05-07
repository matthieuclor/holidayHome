export default {
  methods: {
    countObject(objects) {
      return objects.filter(object => object.Destroy != true).length
    },
    attributeIsValid(object, attribute) {
      return !(attribute in object.errors)
    },
    inputClass(object, attribute) {
      if (!this.attributeIsValid(object, attribute)) {
        return 'is-invalid'
      } else if (object[attribute]) {
        return 'is-valid'
      }
    },
    formGroupClass(object, attribute) {
      if (!this.attributeIsValid(object, attribute)) {
        return 'form-group-invalid'
      } else if (object[attribute]) {
        return 'form-group-valid'
      }
    },
    scrollToFirstError() {
      const errors = document.getElementsByClassName('is-invalid')
      if (errors.length == 0) return
      errors[0].scrollIntoView({ behavior: 'smooth', block: 'end' })
    }
  }
}
