class SampleTarget < ApplicationRecord
  belongs_to :sample_student
  belongs_to :sample_test_name
  belongs_to :sample_subject
  belongs_to :sample_max_score

  before_save :calculate_target_achievement_rate

  validate :target_achievement_rate_within_range
  validates :target_score, presence: true
  validates :target_preparation_time_minutes, presence: true

  def display_preparation_time
    hours = target_preparation_time_minutes / 60
    minutes = target_preparation_time_minutes % 60
    "#{hours}時間#{minutes}分"
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "sample_max_score_id", "sample_student_id", "sample_subject_id", "sample_test_name_id", "target_achievement_rate", "target_preparation_time_minutes", "target_score", "updated_at"]
  end

  private

  def calculate_target_achievement_rate
    return if target_score.nil? || sample_max_score.nil?

    max_score_value = sample_max_score.max_score
    self.target_achievement_rate = ((target_score.to_f / max_score_value) * 100).round
  end

  def target_achievement_rate_within_range
    if target_score.present? && sample_max_score.present?
      calculated_target_achievement_rate = ((target_score.to_f / sample_max_score.max_score) * 100).round
      if calculated_target_achievement_rate > 100
        errors.add(:target_score, "達成率は100%を超えることはできません")
      end
    end
  end
end
