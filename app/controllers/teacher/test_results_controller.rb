class Teacher::TestResultsController < Teacher::BaseController
  before_action :find_test_result, only: [:edit, :update, :show, :destroy]

  def index
    @students = current_teacher_teacher.school.students
    @q = TestResult.where(student_id: @students.pluck(:id)).ransack(params[:q])
    @test_results = @q.result(distinct: true).order(created_at: :desc)
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

  def show
    @target = Target.find_by(test_name_id: @test_result.test_name_id, subject_id: @test_result.subject_id)
  end

  def destroy
    @test_result.destroy!
    redirect_to teacher_test_results_path, success: t('defaults.message.deleted', item: TestResult.model_name.human)
  end

  def subject_achievement_rate
    @student = Student.find(params[:id])
    @subjects = current_teacher_teacher.subjects.pluck(:subject_name)
    @data_by_subject = {}
    @subjects.each do |subject|
      @data_by_subject[subject] = {
        line_chart_data: @student.test_results.achievement_rate_by_subject(subject).map.with_index { |(test_name, achievement_rate), index| ["#{test_name} (#{index + 1})", achievement_rate] },
        scatter_chart_data: @student.test_results.scatter_chart_data_by_subject(subject)
      }
    end
  end

  def average_achievement_rate_ranking
    school_id = current_teacher_teacher.school_id
    @students = Student.where(school_id: school_id, grade: 1..3)
    @ranking = {}
  
    selected_grade = params[:grade] # 選択された学年

    if selected_grade.present? # 学年が選択されている場合
      students_in_grade = @students.where(grade: selected_grade.to_i)

      average_achievement_rates = {}
      students_in_grade.each do |student|
        achievement_rates = student.test_results.pluck(:achievement_rate)
        average_achievement_rate = achievement_rates.sum / achievement_rates.size.to_f
        average_achievement_rates[student] = average_achievement_rate
      end

      ranked_students = average_achievement_rates.sort_by { |_student, rate| rate.nan? ? 0 : rate }.reverse
      @ranking[selected_grade] = ranked_students.map.with_index { |(student, rate), index| { rank: index + 1, student: student, average_achievement_rate: rate } }
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
