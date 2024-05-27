class SampleStudent::SampleTestResultsController < SampleStudent::BaseController 
  
  def index
    @q = current_sample_student_sample_student.sample_test_results.ransack(params[:q])
    @sample_test_results = @q.result.order(created_at: :desc)
  end
  
  def subject_achievement_rate
    sample_teacher = SampleTeacher.find_by(sample_school_id: current_sample_student_sample_student.sample_school_id)
    if sample_teacher.present?
      @sample_subjects = sample_teacher.sample_subjects.pluck(:subject_name)
    else
      @sample_subjects = [] # teacherが存在しない場合は空の配列を代入する
    end
    @data_by_sample_subject = {}
    @sample_subjects.each do |sample_subject|
      @data_by_sample_subject[sample_subject] = {
        line_chart_data: current_sample_student_sample_student.sample_test_results.achievement_rate_by_subject(sample_subject)
                                .reverse # データを逆順にする
                                .map.with_index { |(test_name, achievement_rate), index| ["#{test_name} (#{index + 1})", achievement_rate] },
        scatter_chart_data: current_sample_student_sample_student.sample_test_results.scatter_chart_data_by_subject(sample_subject)
      }
    end
  end
  
  private
  
  def sample_test_result_params
    params.require(:sample_test_result).permit(:sample_test_name_id, :score, :sample_max_score_id, :preparation_time_minutes, :sample_subject_id)
  end
end
  