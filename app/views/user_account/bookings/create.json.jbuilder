json.plan_error @plan_error if @plan_error

if flash.present?
  json.flashes flash do |key, value|
    json.key key
    json.value value
  end

  flash.clear
end
