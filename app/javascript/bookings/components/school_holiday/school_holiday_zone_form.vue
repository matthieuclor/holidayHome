<template>
  <div class="d-flex justify-content-center align-items-center">
    <span>Vacances scolaires :</span>

    <div v-for="(value, key) in currentSchoolHolidayZones"
         :key="key"
         class="custom-control custom-checkbox ml-2">

      <input @change="update_current_school_holiday_zones(
               { key: key, value: !(value == 'true') }
             )"
             type="checkbox"
             class="custom-control-input"
             :id="`zone${key}`"
             :checked="value == 'true'">

      <label class="custom-control-label" :class="checkbox_class(key)" :for="`zone${key}`">
        Zone {{ key }}
      </label>
    </div>
  </div>
</template>

<script>
  import { mapGetters, mapActions } from 'vuex'

  export default {
    name: 'SchoolHolidayZoneForm',
    computed: {
      ...mapGetters(['currentSchoolHolidayZones'])
    },
    methods: {
      ...mapActions(['update_current_school_holiday_zones']),
      checkbox_class(zone) {
        switch (zone) {
          case 'A':
            return 'blue-checkbox'
          case 'B':
            return 'red-checkbox'
          case 'C':
            return 'yellow-checkbox'
        }
      }
    }
  }
</script>

<style scoped>
  .custom-control-input:checked ~ .custom-control-label.blue-checkbox::before {
    border-color: #3182ce;
    background-color: #3182ce;
  }

  .custom-control-input:checked ~ .custom-control-label.red-checkbox::before {
    border-color: #e53e3e;
    background-color: #e53e3e;
  }

  .custom-control-input:checked ~ .custom-control-label.yellow-checkbox::before {
    border-color: #d69e2e;
    background-color: #d69e2e;
  }
</style>
