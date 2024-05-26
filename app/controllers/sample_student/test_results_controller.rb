class Student::TestResultsController < Student::BaseController 

  before_action :find_test_result, only: [:edit, :update, :destroy]
  
  def index
    @q = current_student.test_results.ransack(params[:q])
    @test_results = @q.result.order(created_at: :desc)
  end
  
  def new
    teacher = Teacher.find_by(school_id: current_student.school_id)
    if teacher.present?
      @test_names = TestName.where(teacher_id: teacher.id)
      @subjects = Subject.where(teacher_id: teacher.id)
      @max_scores = MaxScore.where(teacher_id: teacher.id)
    end
    @test_result = TestResult.new
  end
  
  def create
    @test_result = current_student.test_results.build(test_result_params)
    if @test_result.save
      redirect_to test_results_path, success: t('defaults.message.created', item: TestResult.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: TestResult.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
    teacher = Teacher.find_by(school_id: current_student.school_id)
    @test_result = current_student.test_results.find(params[:id])
    @test_names = TestName.where(teacher_id: teacher.id)
    @subjects = Subject.where(teacher_id: teacher.id)
    @max_scores = MaxScore.where(teacher_id: teacher.id)
  end
  
  def update
    @test_result = current_student.test_results.find(params[:id])
    if @test_result.update(test_result_params)
      redirect_to test_results_path, success: t('defaults.message.updated', item: TestResult.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: TestResult.model_name.human)
      render :edit
    end
  end
  
  def destroy
    @test_result = current_student.test_results.find(params[:id])
    @test_result.destroy!
    redirect_to test_results_path, success: t('defaults.message.deleted', item: TestResult.model_name.human)
  end
  
  def subject_achievement_rate
    teacher = Teacher.find_by(school_id: current_student.school_id)
    if teacher.present?
      @subjects = teacher.subjects.pluck(:subject_name)
    else
      @subjects = [] # teacherが存在しない場合は空の配列を代入する
    end
    @data_by_subject = {}
    @subjects.each do |subject|
      @data_by_subject[subject] = {
        line_chart_data: current_student.test_results.achievement_rate_by_subject(subject)
                                .reverse # データを逆順にする
                                .map.with_index { |(test_name, achievement_rate), index| ["#{test_name} (#{index + 1})", achievement_rate] },
        scatter_chart_data: current_student.test_results.scatter_chart_data_by_subject(subject)
      }
    end
  end
  
  private
  
  def find_test_result
    @test_result = current_student.test_results.find(params[:id])
  end
  
  def test_result_params
    params.require(:test_result).permit(:test_name_id, :score, :max_score_id, :preparation_time_minutes, :subject_id)
  end
end
  