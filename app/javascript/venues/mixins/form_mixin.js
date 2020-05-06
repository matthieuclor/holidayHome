export default {
  methods: {
    countObject: function(objects) {
      return objects.filter(object => object.Destroy != true).length
    },
    attributeIsValid: function(object, attribute) {
      return !(attribute in object.errors)
    },
    inputClass: function(object, attribute) {
      if (!this.attributeIsValid(object, attribute)) {
        return 'is-invalid'
      } else if (object[attribute]) {
        return 'is-valid'
      }
    },
    formGroupClass: function(object, attribute) {
      if (!this.attributeIsValid(object, attribute)) {
        return 'form-group-invalid'
      } else if (object[attribute]) {
        return 'form-group-valid'
      }
    }
  }
}
