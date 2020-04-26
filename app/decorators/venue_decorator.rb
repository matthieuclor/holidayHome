# frozen_string_literal: true

class VenueDecorator < ApplicationDecorator
  def beddings_count
    bedrooms.inject(0) do |sum, bedroom|
      sum + bedroom.beddings.inject(0) do |sum_bedding, bedding|
        sum_bedding + case bedding
          when -> (b) { b.single? } then bedding.bed_count
          when -> (b) { b.double? } then (bedding.bed_count * 2)
          else
            0
        end
      end
    end
  end

  def baby_beddings_count
    bedrooms.inject(0) do |sum, bedroom|
      sum + bedroom.beddings.inject(0) do |sum_bedding, bedding|
        sum_bedding + if bedding.baby?
          bedding.bed_count
        else
          0
        end
      end
    end
  end

  def is_editable?
    return true if editable_for_others
    creator_id == current_user&.id
  end
end
