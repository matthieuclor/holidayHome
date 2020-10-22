# frozen_string_literal: true

module FamiliesHelper
  def family_plan_badge(family)
    badge_class = case
      when family.basic? then 'secondary'
      when family.premium? then 'success'
    end

    content_tag(
      :span,
      Family.human_attribute_name("plan.#{family.plan}"),
      class: ["badge badge-#{badge_class}"]
    )
  end
end
