class Subject < ApplicationRecord
  belongs_to :teacher
  has_many :test_results, dependent: :restrict_with_exception
  validates :subject_name, presence: true
end
