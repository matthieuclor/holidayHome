document.addEventListener('turbolinks:load', () => {
  forms = document.querySelectorAll("form[data-autosubmit=true]")
  forms.forEach((form) => {
    form.addEventListener('change', () => {
      if (form.getAttribute("data-remote") == 'true') {
        Rails.fire(form, 'submit')
      } else {
        $(form).submit()
      }
    })
  })
})
