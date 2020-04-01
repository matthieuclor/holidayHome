document.addEventListener('turbolinks:load', () => {
  forms = document.querySelectorAll("form[data-autosubmit=true]")
  forms.forEach((form) => {
    form.addEventListener('change', () => $(form).submit())
  })
})
