<template>
  <div>
    <div v-if="venueFormItem">
      <div class="d-flex justify-content-between align-items-center mb-2">
        <h1 class="m-0">
          {{ (id ? "Editer" : "Créer") + " un lieu" }}
        </h1>

        <router-link v-if="id" :to="{ name: 'venue', params: { id: id } }">
          <button type="button" class="btn btn-link text-muted ml-2">
            <i class="fas fa-arrow-alt-left fa-2x"></i>
          </button>
        </router-link>

        <button v-else
                @click="hideSidebar"
                type="button"
                class="btn btn-link text-muted ml-2">

          <i class="far fa-times fa-2x"></i>
        </button>
      </div>

      <form @submit.prevent="submitVenueForm" class="mt-4">
        <div class="form-group hidden venue_id form-group-valid">
          <input type="hidden"
                 :value="venueFormItem.id"
                 name="venue[id]"
                 id="venue_id"
                 class="form-control is-valid hidden">
        </div>

        <VenueNameForm />

        <div class="form-group hidden venue_creator_id form-group-valid">
          <input type="hidden"
                 :value="venueFormItem.creatorId"
                 name="venue[creator_id]"
                 id="venue_creator_id"
                 class="form-control is-valid hidden">
        </div>

        <div class="form-group hidden venue_family_id form-group-valid">
          <input type="hidden"
                 :value="venueFormItem.familyId"
                 name="venue[family_id]"
                 id="venue_family_id"
                 class="form-control is-valid hidden">
        </div>

        <VenuePlacesForm />

        <hr class="my-4">

        <VenuePhotosForm :venueForm="venueFormItem" :venueId="id" />

        <hr class="my-4">

        <VenueBedroomForm />

        <hr class="my-4">

        <VenueBathroomForm />

        <hr class="my-4">

        <VenueSofaBedsForm />

        <hr class="my-4">

        <VenueAccessoriesForm />

        <hr class="my-4">

        <KeyListForm :keys="venueFormItem.keys" />

        <hr class="my-4">

        <NetworkListForm :networks="venueFormItem.networks" />

        <hr class="my-4">

        <DigitalCodeListForm :digitalCodes="venueFormItem.digitalCodes" />

        <hr class="my-4">

        <HomeServiceListForm :homeServices="venueFormItem.homeServices" />

        <hr class="my-4">

        <VenueCommentForm />

        <VenueEditableForOthersForm v-if="venueFormItem.currentUserIsTheCreator" />

        <input type="submit"
               :disabled="venueFormIsSending"
               name="commit"
               value="Enregistrer"
               class="btn btn-block btn-success">

        <div class='tr-footer'></div>
      </form>
    </div>

    <VenueFormSkeleton v-else />
  </div>
</template>

<script>
import VenueNameForm from 'venues/components/venue/venue_name_form';
import VenueFormSkeleton from 'venues/components/skeleton/venue_form_skeleton';
import VenuePlacesForm from 'venues/components/venue/venue_places_form';
import VenuePhotosForm from 'venues/components/venue/venue_photos_form';
import VenueBedroomForm from 'venues/components/venue/venue_bedroom_form';
import VenueSofaBedsForm from 'venues/components/venue/venue_sofa_beds_form';
import VenueAccessoriesForm from 'venues/components/venue/venue_accessories_form';
import VenueBathroomForm from 'venues/components/venue/venue_bathroom_form';
import KeyListForm from 'venues/components/key/key_list_form';
import NetworkListForm from 'venues/components/network/network_list_form';
import DigitalCodeListForm from 'venues/components/digital_code/digital_code_list_form';
import HomeServiceListForm from 'venues/components/home_service/home_service_list_form';
import VenueCommentForm from 'venues/components/venue/venue_comment_form';
import VenueEditableForOthersForm from 'venues/components/venue/venue_editable_for_others_form';
import formMixin from 'shared/mixins/form_mixin';
import { mapGetters, mapActions } from 'vuex';

export default {
  name: 'VenueForm',
  data() {
    return { venueFormIsSending: false };
  },
  props: ['id'],
  mixins: [formMixin],
  components: {
    VenueNameForm,
    VenueFormSkeleton,
    VenuePlacesForm,
    VenuePhotosForm,
    VenueBedroomForm,
    VenueBathroomForm,
    VenueSofaBedsForm,
    VenueAccessoriesForm,
    KeyListForm,
    NetworkListForm,
    DigitalCodeListForm,
    HomeServiceListForm,
    VenueCommentForm,
    VenueEditableForOthersForm,
  },
  computed: {
    ...mapGetters(['venueFormItem']),
  },
  methods: {
    ...mapActions([
      'getVenueFormItem',
      'sendVenueForm',
      'hideSidebar',
    ]),
    submitVenueForm({ target }) {
      this.venueFormIsSending = true;

      this.sendVenueForm(new FormData(target))
        .then((response) => {
          this.$router.push({
            name: 'venue',
            params: { id: response.data.venue.id },
          });
        }).catch(
          () => this.scrollToFirstError(),
        ).then(
          () => { this.venueFormIsSending = false; },
        );
    },
  },
  watch: {
    id: {
      handler() {
        this.getVenueFormItem(this.id);
      },
      immediate: true,
    },
  },
};
</script>
