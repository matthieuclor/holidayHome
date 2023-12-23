ActiveSupport.on_load :action_view_test_case do
  attr_reader :rendered
end