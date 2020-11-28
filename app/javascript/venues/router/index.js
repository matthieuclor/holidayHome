import Vue from 'vue/dist/vue.esm';
import VueRouter from 'vue-router';
import VenueSkeleton from 'venues/components/skeleton/venue_skeleton';
import Venue from 'venues/components/venue/venue';
import VenueForm from 'venues/components/venue/venue_form';

Vue.use(VueRouter);

export default new VueRouter({
  routes: [
    {
      name: 'venues',
      path: '/',
      component: VenueSkeleton,
    },
    {
      name: 'newVenue',
      path: '/new',
      component: VenueForm,
    },
    {
      name: 'venue',
      path: '/:id',
      component: Venue,
      props: true,
    },
    {
      name: 'editVenue',
      path: '/:id/edit',
      component: VenueForm,
      props: true,
    },
  ],
});
