document.addEventListener('turbolinks:load', () => {
  document.querySelectorAll('.close-card').forEach((card) => {
    const closeCard = document.getElementById(card.getAttribute('data-target'));

    if (closeCard) {
      card.addEventListener('click', () => closeCard.remove());
    }
  });
});
