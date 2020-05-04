<template>
  <div>
    <h1>
      {{ (formIsEditing ? "Editer" : "Créer") + " un lieu" }}
    </h1>

    <form v-if="newVenueItem" @submit.prevent="sendVenueForm">

      <div class="form-group file optional venue_photos">
        <label for="venue_photos" class="file optional">
          Photos
        </label>
        <input multiple="multiple"
              type="file"
              name="venue[photos][]"
              id="venue_photos"
              class="form-control-file file optional">
      </div>

      <div class="form-group string required venue_name">
        <label for="venue_name" class="string required">
          Nom <abbr title="obligatoire">*</abbr>
        </label>
        <input placeholder="Chalet à la montagne"
              required="required"
              aria-required="true"
              type="text"
              :value="newVenueItem.name"
              name="venue[name]"
              id="venue_name"
              class="form-control string required">
      </div>

      <div class="form-group hidden venue_creator_id form-group-valid">
        <input type="hidden"
              :value="newVenueItem.creator_id"
              name="venue[creator_id]"
              id="venue_creator_id"
              class="form-control is-valid hidden">
      </div>

      <div class="form-group hidden venue_family_id form-group-valid">
        <input type="hidden"
              :value="newVenueItem.family_id"
              name="venue[family_id]"
              id="venue_family_id"
              class="form-control is-valid hidden">
      </div>

      <VenuePlaces v-if="newVenueItem" />

      <BedroomListForm :bedrooms="newVenueItem.bedrooms" />

      <hr class="my-4">

      <BathroomListForm :bathrooms="newVenueItem.bathrooms" />

      <hr class="my-4">

      <div class="form-group text optional venue_comment">
        <label for="venue_comment" class="text optional">
          Commentaire
        </label>
        <textarea placeholder="Choses à savoir, bon plan, précision sur le lieu..."
                  :value="newVenueItem.comment"
                  name="venue[comment]"
                  id="venue_comment"
                  class="form-control text optional">
        </textarea>
      </div>

      <fieldset class="form-group boolean optional venue_editable_for_others form-group-valid">
        <div class="custom-control custom-switch">
          <input name="venue[editable_for_others]"
                 type="hidden"
                 :value="newVenueItem.editableForOthers">
          <input type="checkbox"
                 :value="newVenueItem.editableForOthers"
                 :checked="newVenueItem.editableForOthers"
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
             name="commit"
             value="Envoyer"
             class="btn btn-block btn-success">
    </form>
  </div>
</template>

<script>
  import VenuePlaces from 'venues/components/venue/venue_places'
  import BedroomListForm from 'venues/components/bedroom/bedroom_list_form'
  import BathroomListForm from 'venues/components/bathroom/bathroom_list_form'
  import { mapGetters, mapActions } from 'vuex'

  export default {
    name: 'VenueForm',
    components: {
      VenuePlaces,
      BedroomListForm,
      BathroomListForm
    },
    computed: {
      ...mapGetters([
        'newVenueItem',
        'formIsEditing'
      ])
    },
    methods: {
      ...mapActions([
        'getNewVenueItem'
      ]),
      sendVenueForm(event) {
        const formData = new FormData(event.target)
      }
    },
    created() {
      if (!this.newVenueItem) this.getNewVenueItem()
    }
  }
</script>
