class Bedding < ApplicationRecord
  belongs_to :bedroom

  enum bed_type: %i(single double baby)

  validates :bed_type, :bed_count, :bedroom, presence: true
  validates :bed_type, inclusion: { in: bed_types.keys }
  validates :bed_type, uniqueness: { scope: :bedroom_id }

  def to_builder
    Jbuilder.new do |bedding|
      bedding.(self, :id, :bed_type, :bed_count, :_destroy)
    end
  end
end
