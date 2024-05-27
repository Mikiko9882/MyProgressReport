class SampleTeacher::SampleTestResultsController < SampleTeacher::BaseController
  before_action :find_sample_test_result, only: [:show]

  def index
    @sample_students = current_sample_teacher_sample_teacher.sample_school.sample_students
    @q = SampleTestResult.where(sample_student_id: @sample_students.pluck(:id)).ransack(params[:q])
    @sample_test_results = @q.result(distinct: true).order(created_at: :desc)
  end

  def show
    @sample_target = SampleTarget.find_by(sample_test_name_id: @sample_test_result.sample_test_name_id, sample_subject_id: @sample_test_result.sample_subject_id)
  end

  def subject_achievement_rate
    @sample_student = SampleStudent.find(params[:id])
    @sample_subjects = current_sample_teacher_sample_teacher.sample_subjects.pluck(:subject_name)
    @data_by_sample_subject = {}
    @sample_subjects.each do |sample_subject|
      @data_by_sample_subject[sample_subject] = {
        line_chart_data: @sample_student.sample_test_results.achievement_rate_by_subject(sample_subject).map.with_index { |(test_name, achievement_rate), index| ["#{test_name} (#{index + 1})", achievement_rate] },
        scatter_chart_data: @sample_student.sample_test_results.scatter_chart_data_by_subject(sample_subject)
      }
    end
  end

  def average_achievement_rate_ranking
    sample_school_id = current_sample_teacher_sample_teacher.sample_school_id
    @sample_students = SampleStudent.where(sample_school_id: sample_school_id, grade: 1..3)
    @ranking = {}
  
    selected_grade = params[:grade] # 選択された学年

    if selected_grade.present? # 学年が選択されている場合
      sample_students_in_grade = @sample_students.where(grade: selected_grade.to_i)

      average_achievement_rates = {}
      sample_students_in_grade.each do |sample_student|
        achievement_rates = sample_student.sample_test_results.pluck(:achievement_rate)
        average_achievement_rate = achievement_rates.sum / achievement_rates.size.to_f
        average_achievement_rates[sample_student] = average_achievement_rate
      end

      ranked_sample_students = average_achievement_rates.sort_by { |sample_student, rate| rate.nan? ? 0 : rate }.reverse
      @ranking[selected_grade] = ranked_sample_students.map.with_index { |(sample_student, rate), index| { rank: index + 1, sample_student: sample_student, average_achievement_rate: rate } }
    end
  end

  private

  def find_sample_test_result
    @sample_test_result = SampleTestResult.find(params[:id])
  end

  def sample_test_result_params
    params.require(:sample_test_result).permit(:sample_test_name_id, :score, :sample_max_score_id, :preparation_time_minutes, :sample_subject_id)
  end
end
