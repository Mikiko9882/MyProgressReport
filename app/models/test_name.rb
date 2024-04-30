class TestName < ApplicationRecord
  belongs_to :teacher
  has_many :test_results, dependent: :restrict_with_exception
  
  validates :test_name, presence: true
end
