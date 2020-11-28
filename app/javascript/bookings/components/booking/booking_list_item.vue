<template>
  <a :href="`/user_account/bookings/${bookingPendingItem.id}`"
     data-turbolinks="false"
     class="list-group-item list-group-item-action text-center rounded">
    Demande de <span class="font-weight-bold">{{bookingPendingItem.userFullName}}</span>
    <span class="font-weight-bold">{{bookingPendingItem.humanDateRange}}</span>
    <span>{{bookingPendingItem.progressTitle}}</span>
  </a>
</template>

<script>
export default {
  name: 'BookingListItem',
  props: ['bookingPendingItem'],
};
</script>
