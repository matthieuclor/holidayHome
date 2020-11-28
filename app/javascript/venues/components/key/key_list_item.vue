<template>
  <div class="shadow p-3 rounded mb-3">
    <span>{{ keyItem.name }} :</span>

    <a data-remote="true" :href="`/user_account/users/${keyItem.owner.id}`">
      <span class="text-muted">
        {{ `${keyItem.owner.firstName} ${keyItem.owner.lastName}` }}
      </span>
    </a>
  </div>
</template>

<script>
export default {
  name: 'KeyListItem',
  props: ['keyItem'],
};
</script>
