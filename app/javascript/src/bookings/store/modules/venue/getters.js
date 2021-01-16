import { chunk } from 'lodash';

export default {
  venueItems: (state) => state.venueItems,
  chunkedVenueItems: (state) => chunk(state.venueItems, 3),
  currentVenue: (state) => state.currentVenue,
};
