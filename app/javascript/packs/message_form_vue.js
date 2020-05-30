import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'
import axios from 'axios'
import qs from 'qs'

Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  const element = document.getElementById('message-form-container')

  if (element) {
    const contentMax = element.getAttribute('data-content-max')
    const csrfToken = document.querySelector('[name=csrf-token]').content
    const form = document.getElementById('new_message')

    new Vue({
      el: element,
      data() {
        return {
          message: '',
          showMessageFormError: false,
          messageFormError: null
        }
      },
      computed: {
        contentMax: () => contentMax,
        charCount() {
          return this.message.length
        },
      },
      methods: {
        submitForm() {
          if (this.charCount > 0) {
            axios(
              {
                method: 'post',
                url: `${form.getAttribute('action')}.json`,
                data: qs.stringify({ message: { content: this.message } }),
                headers: { 'X-CSRF-TOKEN': csrfToken }
              }
            ).then(() => {
              this.showMessageFormError = false
              this.messageFormError = ''
              this.message = ''
            }).catch(error => {
              this.messageFormError = error.response.data.error
              this.showMessageFormError = true
            })
          }
        }
      },
      watch: {
        message() {
          if (this.charCount > this.contentMax) {
            this.message = this.message.substring(0, this.contentMax)
          }
        }
      }
    })
  }
})
