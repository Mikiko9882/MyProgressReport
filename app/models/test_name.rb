class TestName < ApplicationRecord
  belongs_to :teacher
  validates :test_name, presence: true
end
