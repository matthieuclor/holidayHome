export default {
  methods: {
    countObject(objects) {
      return objects.filter((object) => object.Destroy !== true).length;
    },
    attributeIsValid(object, attribute) {
      return !(attribute in object.errors);
    },
    inputClass(object, attribute) {
      let validClass = '';

      if (!this.attributeIsValid(object, attribute)) {
        validClass = 'is-invalid';
      } else if (object[attribute]) {
        validClass = 'is-valid';
      }

      return validClass;
    },
    formGroupClass(object, attribute) {
      let formGroupClass = '';

      if (this.attributeIsValid(object, attribute)) {
        formGroupClass = 'form-group-invalid';
      } else if (object[attribute]) {
        formGroupClass = 'form-group-valid';
      }

      return formGroupClass;
    },
    scrollToFirstError() {
      const errors = document.getElementsByClassName('is-invalid');
      if (errors.length === 0) return;
      errors[0].scrollIntoView({ behavior: 'smooth', block: 'center' });
    },
  },
};
