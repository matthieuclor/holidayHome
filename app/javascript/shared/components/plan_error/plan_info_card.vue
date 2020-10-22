<template>
  <div class="card fixed-bottom m-3">
    <div class="card-body">
      <div class="d-flex justify-content-between mb-3">
        <div class="alert alert-danger m-0" role="alert">
          <i class="fas fa-exclamation-triangle"></i>
          <span class="ml-1">{{ planError }}</span>
        </div>
        <div class="cursor-pointer ml-4">
          <i @click="removePlanError"
             class="fas fa-times fa-2x text-muted p-1">
          </i>
        </div>
      </div>

      <div class="row">
        <div class="col-sm-5">
          <h4 class="mb-3">
            <span>Le plan Basique limite vos actions !</span>
          </h4>

          <ul class="list-unstyled mb-0">
            <li>
              <i class="fas fa-check-circle text-warning"></i>
              <span class="text-muted">Vous ne pouvez gérer qu'une seule famille</span>
            </li>
            <li>
              <i class="fas fa-check-circle text-warning"></i>
              <span class="text-muted">Vous ne pouvez avoir que 3 membres liés à cette famille</span>
            </li>
            <li>
              <i class="fas fa-check-circle text-warning"></i>
              <span class="text-muted">Vous ne pouvez gérer qu'un lieu sur cette famille</span>
            </li>
            <li>
              <i class="fas fa-check-circle text-warning"></i>
              <span class="text-muted">Et vous ne pouvez mettre qu'une seule photo sur ce lieu</span>
            </li>
          </ul>

          <hr class="d-sm-none my-3">
        </div>

        <div class="col-sm-4">
          <h4 class="mb-3">Pourquoi passer au plan Premium ?</h4>

          <ul class="list-unstyled mb-0">
            <li>
              <i class="fas fa-check-circle text-success"></i>
              <span class="text-muted">Familles illimitées</span>
            </li>
            <li>
              <i class="fas fa-check-circle text-success"></i>
              <span class="text-muted">Membres par famille illimités</span>
            </li>
            <li>
              <i class="fas fa-check-circle text-success"></i>
              <span class="text-muted">Lieux par famille illimités</span>
            </li>
            <li>
              <i class="fas fa-check-circle text-success"></i>
              <span class="text-muted">10 photos par lieu</span>
            </li>
          </ul>

          <hr class="d-sm-none my-3">
        </div>

        <div class="col-sm-3 my-auto">
          <div class="text-center text-opacity-3">
            <span class="font-weight-bolder font-size-1-2 text-line-through">
              29 €
            </span>
            <span class="text-muted">par an</span>
          </div>
          <div class="text-primary text-center text-wrap">
            <span class="font-weight-bolder font-size-1-2">
              Gratuit 🎉
            </span>
            <span class="text-nowrap">(Offre pour le lancement)</span>
          </div>
          <button type="button" class="btn btn-block btn-outline-primary">
            Plan premium
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import { mapActions } from 'vuex'

  export default {
    name: 'PlanInfoCard',
    props: ['planError'],
    methods: {
      ...mapActions(['updatePlanError']),
      removePlanError() {
        this.updatePlanError(null)
      }
    }
  }
</script>
