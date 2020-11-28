document.addEventListener('turbolinks:load', () => {
  const forms = document.querySelectorAll('form[data-autosubmit=true]');

  forms.forEach((form) => {
    form.addEventListener('change', () => {
      if (form.getAttribute('data-remote') === 'true') {
        window.Rails.fire(form, 'submit');
      } else {
        $(form).submit();
      }
    });
  });
});
