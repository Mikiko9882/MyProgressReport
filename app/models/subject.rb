class Subject < ApplicationRecord
  belongs_to :teacher
  has_many :test_results, dependent: :restrict_with_exception
  has_many :targets, dependent: :destroy

  validates :subject_name, presence: true
end
