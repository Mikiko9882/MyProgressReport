class MaxScore < ApplicationRecord
  belongs_to :teacher

  validates :max_score, presence: true
end
