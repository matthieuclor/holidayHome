import consumer from './consumer';

document.addEventListener('turbolinks:load', () => {
  const element = document.getElementById('notification-container');

  if (element) {
    consumer.subscriptions.create(
      {
        channel: 'NotificationChannel',
        family_id: element.getAttribute('data-user-id'),
      }, {
        received(data) {
          $('#notification-container').html(data.notifications);
          $('#toast-container').prepend(data.flashes);
        },
      },
    );
  }
});
