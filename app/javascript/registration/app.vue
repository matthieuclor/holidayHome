<template>
  <div class="form-group tel optional user_phone form-group-valid">
    <label class="tel optional" for="user_phone">Téléphone</label>
    <VueTelInput v-model="userPhone" v-bind="userPhoneProps" />
  </div>
</template>

<script>
import { VueTelInput } from 'vue-tel-input';

export default {
  name: 'App',
  data() {
    return {
      userPhone: this.dataUserPhone(),
      userPhoneProps: {
        mode: 'international',
        defaultCountry: 'FR',
        placeholder: '06 66 76 45 45',
        name: 'user[phone]',
        inputId: 'user_phone',
        inputClasses: 'form-control string',
      },
    };
  },
  components: {
    VueTelInput,
  },
  methods: {
    dataUserPhone() {
      return document
        .getElementById('registration-container')
        .getAttribute('data-user-phone');
    },
  },
};
</script>
