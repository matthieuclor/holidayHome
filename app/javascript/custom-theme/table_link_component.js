document.addEventListener('turbolinks:load', () => {
  document.querySelectorAll('[data-table-link]').forEach((link) => {
    link.addEventListener('click', () => {
      if (link.getAttribute('data-remote') === 'true') {
        $.ajax(link.getAttribute('data-table-link'));
      } else {
        window.location.assign(link.getAttribute('data-table-link'));
      }
    });
  });
});
