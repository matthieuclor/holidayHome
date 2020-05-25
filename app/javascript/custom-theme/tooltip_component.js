document.addEventListener('turbolinks:load', () => {
  const tooltipElement = $('[data-toggle="tooltip"]')
  if (tooltipElement.length > 0) tooltipElement.tooltip()
})
