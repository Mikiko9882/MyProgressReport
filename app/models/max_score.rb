class MaxScore < ApplicationRecord
  belongs_to :teacher
  has_many :test_results, dependent: :restrict_with_exception
  has_many :targets, dependent: :destroy

  validates :max_score, presence: true
end
