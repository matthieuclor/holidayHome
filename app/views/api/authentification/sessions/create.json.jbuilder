# frozen_string_literal: true

json.user do
  json.call(
    @user,
    :id,
    :first_name,
    :last_name,
    :email,
    :phone,
    :address,
    :current_family_id,
    :current_venue_id,
    :current_school_holiday_zones,
    :plan,
    :plan_deadline
  )

  json.auth_token @jwt_token
end
