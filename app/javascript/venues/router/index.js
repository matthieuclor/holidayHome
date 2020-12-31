import Vue from 'vue/dist/vue.esm';
import VueRouter from 'vue-router';
import VenueSkeleton from 'venues/components/skeleton/venue_skeleton';
import Venue from 'venues/components/venue/venue';
import Vehicles from 'venues/components/vehicle/vehicles';
import VehicleForm from 'venues/components/vehicle/vehicle_form';
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
    {
      name: 'vehicles',
      path: '/:venueId/vehicles',
      component: Vehicles,
      props: true,
    },
    {
      name: 'newVehicle',
      path: '/:venueId/vehicles/new',
      component: VehicleForm,
      props: true,
    },
    {
      name: 'editVehicle',
      path: '/:venueId/vehicles/:id/edit',
      component: VehicleForm,
      props: true,
    },
  ],
});
