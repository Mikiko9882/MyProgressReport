class Teacher::TestResultsController < Teacher::BaseController
  before_action :find_test_result, only: [:edit, :update, :show, :destroy]

  def index
    @students = current_teacher_teacher.school.students
    @q = TestResult.where(student_id: @students.pluck(:id)).ransack(params[:q])
    @test_results = @q.result(distinct: true).order(created_at: :desc).page(params[:page])
  end

  def edit; end

  def update
    if @test_result.update(test_result_params)
      redirect_to teacher_test_result_path(@test_result), success: t('defaults.message.updated', item: TestResult.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: TestResult.model_name.human)
      render :edit
    end
  end

  def show; end

  def destroy
    @test_result.destroy!
    redirect_to teacher_test_results_path, success: t('defaults.message.deleted', item: TestResult.model_name.human)
  end

  def subject_achievement_rate
    @student = Student.find(params[:id])
    @subjects = Subject.pluck(:subject_name)
    @data_by_subject = {}
    @subjects.each do |subject|
      @data_by_subject[subject] = {
        line_chart_data: @student.test_results.achievement_rate_by_subject(subject).map.with_index { |(test_name, achievement_rate), index| ["#{test_name} (#{index + 1})", achievement_rate] },
        scatter_chart_data: @student.test_results.scatter_chart_data_by_subject(subject)
      }
    end
  end

  private

  def find_test_result
    @test_result = TestResult.find(params[:id])
  end

  def test_result_params
    params.require(:test_result).permit(:test_name_id, :score, :max_score_id, :preparation_time_minutes, :subject_id)
  end
end
