document.addEventListener('turbolinks:load', () => {
  document.querySelectorAll(".password-eye").forEach((passwordEye) => {
    passwordForm = passwordEye.previousElementSibling.querySelector('input.password')

    if (passwordForm) {
      passwordEye.addEventListener('click', () => {
        if (passwordForm.type == 'password') {
          passwordForm.type = ''
          passwordEye.classList.remove("fa-eye")
          passwordEye.classList.add("fa-eye-slash")
        } else {
          passwordForm.type = 'password'
          passwordEye.classList.remove("fa-eye-slash")
          passwordEye.classList.add("fa-eye")
        }
      })
    }
  })
})
