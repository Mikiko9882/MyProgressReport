class Student::TargetsController < Student::BaseController
  before_action :find_target, only: [:edit, :update, :destroy]
  
  def index
    @q = current_student.targets.ransack(params[:q])
    @targets = @q.result.order(created_at: :desc)
  end
  
  def new
    teacher = Teacher.find_by(school_id: current_student.school_id)
    if teacher.present?
      @test_names = TestName.where(teacher_id: teacher.id)
      @subjects = Subject.where(teacher_id: teacher.id)
      @max_scores = MaxScore.where(teacher_id: teacher.id)
    end
    @target = Target.new
  end
  
  def create
    @target = current_student.targets.build(target_params)
    if @target.save
      redirect_to targets_path, success: t('defaults.message.created', item: Target.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: Target.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
    teacher = Teacher.find_by(school_id: current_student.school_id)
    @target = current_student.targets.find(params[:id])
    @test_names = TestName.where(teacher_id: teacher.id)
    @subjects = Subject.where(teacher_id: teacher.id)
    @max_scores = MaxScore.where(teacher_id: teacher.id)
  end
  
  def update
    @target = current_student.targets.find(params[:id])
    if @target.update(target_params)
      redirect_to targets_path, success: t('defaults.message.updated', item: Target.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: Target.model_name.human)
      render :edit
    end
  end
  
  def destroy
    @target = current_student.targets.find(params[:id])
    @target.destroy!
    redirect_to targets_path, success: t('defaults.message.deleted', item: Target.model_name.human)
  end
  
  private
  
  def find_target
    @target = current_student.targets.find(params[:id])
  end
  
  def target_params
    params.require(:target).permit(:test_name_id, :target_score, :max_score_id, :target_preparation_time_minutes, :subject_id)
  end
end
