class Student::StudyPlansController < Student::BaseController
  before_action :find_study_plan, only: [:show, :edit, :update, :destroy]
  before_action :set_beginning_of_week
  
  def index
    @study_plans = current_student.study_plans.order(created_at: :desc)
  end

  def show
  end
  
  def new
    teacher = Teacher.find_by(school_id: current_student.school_id)
    if teacher.present?
      @subjects = Subject.where(teacher_id: teacher.id)
    end
    @study_plan = StudyPlan.new
  end
  
  def create
    @study_plan = current_student.study_plans.build(study_plan_params)
    if @study_plan.save
      redirect_to study_plans_path, success: t('defaults.message.created', item: StudyPlan.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: StudyPlan.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
    teacher = Teacher.find_by(school_id: current_student.school_id)
    @study_plan = current_student.study_plans.find(params[:id])
    @subjects = Subject.where(teacher_id: teacher.id)
  end
  
  def update
    if @study_plan.update(study_plan_params)
      redirect_to study_plans_path, success: t('defaults.message.updated', item: StudyPlan.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: StudyPlan.model_name.human)
      render :edit
    end
  end
  
  def destroy
    @study_plan.destroy!
    redirect_to study_plans_path, success: t('defaults.message.deleted', item: StudyPlan.model_name.human)
  end
  
  private

  def set_beginning_of_week
    Date.beginning_of_week = :sunday
  end
  
  def find_study_plan
    @study_plan = current_student.study_plans.find(params[:id])
  end
  
  def study_plan_params
    params.require(:study_plan).permit(:subject_id, :start_time, :content)
  end
end
