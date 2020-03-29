require 'pagy/extras/bootstrap'
include Pagy::Backend

Pagy::VARS[:items] = 20
Pagy::VARS[:link_extra] = 'data-remote="true"'
