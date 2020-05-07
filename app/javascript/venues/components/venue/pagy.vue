<template>
  <div v-if="venuePagy.series.length > 1" class="d-flex justify-content-center">
    <nav aria-label="venue page navigation">
      <ul class="pagination pagination-sm">
        <li class="page-item" :class="isDisabled(venuePagy.prev)">
          <a @click.prevent="pageLink(venuePagy.prev)"
            href="#"
            class="page-link"
            aria-label="Previous">

            <span aria-hidden="true" v-html="venuePagy.tPrev"></span>
          </a>
        </li>

        <li v-for="(serie, index) in venuePagy.series"
            :key="index"
            class="page-item"
            :class="isActive(serie)">
          <a @click.prevent="isActive(serie) ? null : pageLink(serie)"
            href="#"
            class="page-link">

            {{ serie }}
          </a>
        </li>

        <li class="page-item next" :class="isDisabled(venuePagy.next)">
          <a @click.prevent="pageLink(venuePagy.next)"
            href="#"
            class="page-link"
            aria-label="Next">

            <span aria-hidden="true" v-html="venuePagy.tNext"></span>
          </a>
        </li>
      </ul>
    </nav>
  </div>
</template>

<script>
  import { mapGetters, mapActions } from 'vuex'

  export default {
    name: 'venuePagy',
    computed: {
      ...mapGetters(['venuePagy']),
    },
    methods: {
      ...mapActions(['getVenueItems']),
      isActive(page) {
        return typeof(page) === 'string' ? 'active' : ''
      },
      isDisabled(page) {
        return page ? '' : 'disabled'
      },
      pageLink(page) {
        this.getVenueItems(page)
      }
    }
  }
</script>
