# frozen_string_literal: true

json.user(
  @user,
  :id,
  :first_name,
  :last_name,
  :email,
  :phone,
  :address,
  :current_venue_id,
  :current_school_holiday_zones,
  :plan,
  :plan_deadline
)

json.family do
  json.id(@user.current_family_id)
end

json.venue do
  json.id(@user.current_venue_id[@user.current_family_id.to_s])
end

json.token @jwt_token
