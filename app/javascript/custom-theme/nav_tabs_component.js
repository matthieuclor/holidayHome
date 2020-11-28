document.addEventListener('turbolinks:load', () => {
  if (document.querySelector('.nav-tabs')) {
    const hanchor = window.location.hash.match(/[a-z]+/g);
    if (hanchor) {
      const target = document.querySelector(`.nav-link[data-target='#${hanchor[0]}']`);
      if (target) target.click();
    }
  }
});
