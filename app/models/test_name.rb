class TestName < ApplicationRecord
  belongs_to :teacher
  has_many :test_results, dependent: :restrict_with_exception
  has_many :targets, dependent: :destroy
  
  validates :test_name, presence: true
end
