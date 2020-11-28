document.addEventListener('turbolinks:load', () => {
  document.querySelectorAll('.form-check.password-eye').forEach((passwordEye) => {
    const passwordForm = document.getElementById(passwordEye.getAttribute('data-target'));

    if (passwordForm) {
      passwordEye.addEventListener('change', () => {
        passwordForm.type = (passwordForm.type === 'password') ? '' : 'password';
      });
    }
  });
});
