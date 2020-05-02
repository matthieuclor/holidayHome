import Vue from 'vue/dist/vue.esm'
import VueRouter from 'vue-router'
import VenueSkeleton from 'venues/components/venue/venue_skeleton'
import Venue from 'venues/components/venue/venue'

Vue.use(VueRouter)

export default new VueRouter({
  mode: 'history',
  routes: [
    {
      name:'venues',
      path: '/user_account/venues',
      component: VenueSkeleton
    },
    {
      name:'venue',
      path: '/user_account/venues/:id',
      component: Venue,
      props: true
    },
    {
      path: '/user_account/venues/*',
      redirect: '/user_account/venues'
    }
  ]
})
