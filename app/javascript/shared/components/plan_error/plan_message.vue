<template>
  <div class="card fixed-bottom m-3">
    <div class="card-body">
      <div class="alert alert-danger" role="alert">
        {{ planError }}
      </div>

      <div class="row d-flex align-items-center">
        <div class="col-sm-10">
          <h3 class="mb-3">
            <i class="fas fa-exclamation-triangle text-warning"></i>
            <span>Passez au plan Premium !</span>
          </h3>

          <p class="mb-1 font-weight-bolder">
            Le plan Basique limite vos actions :
          </p>

          <ul class="list-unstyled">
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
        </div>
        <div class="col-sm-2 mb-auto">
          <button @click="removePlanError"
                  type="button"
                  class="btn btn-block btn-primary">
            Fermer
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import { mapActions } from 'vuex'

  export default {
    name: 'PlanMessage',
    props: ['planError'],
    methods: {
      ...mapActions(['updatePlanError']),
      removePlanError() {
        this.updatePlanError(null)
      }
    }
  }
</script>
