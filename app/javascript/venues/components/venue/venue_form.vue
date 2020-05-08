<template>
  <div>
    <div v-if="venueFormItem">
      <h1>
        {{ (id ? "Editer" : "Créer") + " un lieu" }}
      </h1>

      <form @submit.prevent="submitVenueForm" class="mt-4">
        <div class="form-group hidden venue_id form-group-valid">
          <input type="hidden"
                :value="venueFormItem.id"
                name="venue[id]"
                id="venue_id"
                class="form-control is-valid hidden">
        </div>

        <div class="form-group row file optional venue_photos">
          <label for="venue_photos"
                 class="file optional col-sm-2 col-form-label text-nowrap">

            Photos
          </label>

          <div class="col-sm-10 d-flex align-items-center">
            <input multiple="multiple"
                  type="file"
                  name="venue[photos][]"
                  id="venue_photos"
                  class="form-control-file file optional">
          </div>
        </div>

        <div class="form-group row string required venue_name">
          <label for="venue_name"
                 class="string required col-sm-2 col-form-label text-nowrap">

            Nom <abbr title="obligatoire">*</abbr>
          </label>

          <div class="col-sm-10">
            <input placeholder="Chalet à la montagne"
                  required="required"
                  aria-required="true"
                  type="text"
                  :value="venueFormItem.name"
                  name="venue[name]"
                  id="venue_name"
                  class="form-control string required"
                  :class="inputClass(venueFormItem, 'name')"
                  :aria-invalid="!attributeIsValid(venueFormItem, 'name')">
          </div>
        </div>

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

        <VenueBedroomForm />

        <hr class="my-4">

        <VenueBathroomForm />

        <!-- <BathroomListForm :bathrooms="venueFormItem.bathrooms" /> -->

        <hr class="my-4">

        <KeyListForm :keys="venueFormItem.keys" />

        <hr class="my-4">

        <NetworkListForm :networks="venueFormItem.networks" />

        <hr class="my-4">

        <DigitalCodeListForm :digitalCodes="venueFormItem.digitalCodes" />

        <hr class="my-4">

        <HomeServiceListForm :homeServices="venueFormItem.homeServices" />

        <hr class="my-4">

        <div class="form-group text optional venue_comment">
          <label for="venue_comment" class="text optional">
            Commentaire
          </label>
          <textarea placeholder="Choses à savoir, bon plan, précision sur le lieu..."
                    :value="venueFormItem.comment"
                    name="venue[comment]"
                    id="venue_comment"
                    class="form-control text optional"
                    :class="inputClass(venueFormItem, 'comment')"
                    :aria-invalid="!attributeIsValid(venueFormItem, 'comment')">
          </textarea>
        </div>

        <fieldset class="form-group boolean optional venue_editable_for_others form-group-valid">
          <div class="custom-control custom-switch">
            <input name="venue[editable_for_others]"
                  type="hidden"
                  :value="venueFormItem.editableForOthers">
            <input type="checkbox"
                  :value="venueFormItem.editableForOthers"
                  :checked="venueFormItem.editableForOthers"
                  name="venue[editable_for_others]"
                  id="venue_editable_for_others"
                  class="custom-control-input is-valid boolean optional">
            <label for="venue_editable_for_others"
                  class="custom-control-label boolean optional">
              Editable par les autres membres
            </label>
          </div>
        </fieldset>

        <input type="submit"
              :disabled="venueFormIsSending"
              name="commit"
              value="Envoyer"
              class="btn btn-block btn-success">
      </form>
    </div>

    <VenueFormSkeleton v-else/>
  </div>
</template>

<script>
  import VenueFormSkeleton from 'venues/components/venue/venue_form_skeleton'
  import VenuePlacesForm from 'venues/components/venue/venue_places_form'
  import VenueBedroomForm from 'venues/components/venue/venue_bedroom_form'
  import VenueBathroomForm from 'venues/components/venue/venue_bathroom_form'
  import KeyListForm from 'venues/components/key/key_list_form'
  import NetworkListForm from 'venues/components/network/network_list_form'
  import DigitalCodeListForm from 'venues/components/digital_code/digital_code_list_form'
  import HomeServiceListForm from 'venues/components/home_service/home_service_list_form'
  import formMixin from 'venues/mixins/form_mixin'
  import { mapGetters, mapActions } from 'vuex'

  export default {
    name: 'VenueForm',
    data() {
      return { venueFormIsSending: false }
    },
    props: ['id'],
    components: {
      VenueFormSkeleton,
      VenuePlacesForm,
      VenueBedroomForm,
      VenueBathroomForm,
      KeyListForm,
      NetworkListForm,
      DigitalCodeListForm,
      HomeServiceListForm
    },
    computed: {
      ...mapGetters(['venueFormItem'])
    },
    mixins: [formMixin],
    methods: {
      ...mapActions(['getFormData', 'sendVenueForm']),
      submitVenueForm({ target }) {
        this.venueFormIsSending = true
        this.sendVenueForm(new FormData(target))
        .then(response => {
          this.$router.push({
            name: 'venue',
            params: { id: response.data.venue.id }
          })
        }).catch(
          error => this.scrollToFirstError()
        ).then(
          () => this.venueFormIsSending = false
        )
      }
    },
    watch: {
      id: {
        handler() { this.getFormData(this.id) },
        immediate: true
      }
    }
  }
</script>
