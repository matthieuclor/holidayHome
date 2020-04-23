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
end
