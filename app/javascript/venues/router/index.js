import Vue from 'vue/dist/vue.esm'
import VueRouter from 'vue-router'
import VenueSkeleton from 'venues/components/venue/venue_skeleton'
import Venue from 'venues/components/venue/venue'
import VenueForm from 'venues/components/venue/venue_form'

Vue.use(VueRouter)

export default new VueRouter({
  routes: [
    {
      name: 'venues',
      path: '/',
      component: VenueSkeleton
    },
    {
      name: 'venue',
      path: '/:id',
      component: Venue,
      props: true
    },
    {
      name: 'newVenue',
      path: '/new',
      component: VenueForm,
    },
    {
      path: '*',
      redirect: '/'
    }
  ]
})
