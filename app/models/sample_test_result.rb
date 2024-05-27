class SampleTestResult < ApplicationRecord
  belongs_to :sample_test_name
  belongs_to :sample_max_score
  belongs_to :sample_subject
  belongs_to :sample_student

  before_save :calculate_achievement_rate

  validate :achievement_rate_within_range
  validates :score, presence: true
  validates :preparation_time_minutes, presence: true

  def display_preparation_time
    hours = preparation_time_minutes / 60
    minutes = preparation_time_minutes % 60
    "#{hours}時間#{minutes}分"
  end

  def self.achievement_rate_by_subject(subject)
    joins(:sample_subject, :sample_test_name)
      .where(sample_subjects: { subject_name: subject })
      .pluck('sample_test_names.test_name', :achievement_rate)
  end

  def self.scatter_chart_data_by_subject(subject)
    joins(:sample_subject)
      .where(sample_subjects: { subject_name: subject })
      .pluck(:preparation_time_minutes, :achievement_rate)
  end

  def self.ransackable_associations(auth_object = nil)
    ["sample_max_score", "sample_student", "sample_subject", "sample_test_name"]
  end

  private

  def calculate_achievement_rate
    return if score.nil? || max_score.nil?

    max_score_value = max_score.max_score
    self.achievement_rate = ((score.to_f / max_score_value) * 100).round
  end

  def achievement_rate_within_range
    if score.present? && max_score.present?
      calculated_achievement_rate = ((score.to_f / max_score.max_score) * 100).round
      if calculated_achievement_rate > 100
        errors.add(:score, "達成率は100%を超えることはできません")
      end
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["achievement_rate", "created_at", "id", "id_value", "preparation_time_minutes", "sample_max_score_id", "sample_student_id", "sample_subject_id", "sample_test_name_id", "score", "updated_at"]
  end

end
