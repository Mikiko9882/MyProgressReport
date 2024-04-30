class MaxScore < ApplicationRecord
  belongs_to :teacher
  has_many :test_results, dependent: :restrict_with_exception

  validates :max_score, presence: true
end
