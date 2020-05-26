class Review <ApplicationRecord
  belongs_to :item

  validates_inclusion_of :rating, in: 1..5
end
