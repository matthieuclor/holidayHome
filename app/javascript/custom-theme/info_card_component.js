document.addEventListener('turbolinks:load', () => {
  document.querySelectorAll(".close-card").forEach((card) => {
    closeCard = document.getElementById(card.getAttribute('data-target'))

    if (closeCard) {
      card.addEventListener('click', () => {
        closeCard.remove()
      })
    }
  })
})
