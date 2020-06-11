<template>
  <a :href="`/user_account/bookings/${bookingPendingItem.id}`"
     class="list-group-item list-group-item-action text-center">
    Créée le <span class="font-weight-bold">{{bookingPendingItem.createdAt}}</span>
    par <span class="font-weight-bold">{{bookingPendingItem.userName}}</span>
    du <span class="font-weight-bold">{{bookingPendingItem.from}}</span>
    au <span class="font-weight-bold">{{bookingPendingItem.to}}</span>
    il reste <span class="font-weight-bold">{{bookingPendingItem.daysLeft}}</span>
  </a>
</template>

<script>
  import BookingListItem from './booking_list_item'

  export default {
    name: 'BookingListItem',
    props: ['bookingPendingItem']
  }
</script>
