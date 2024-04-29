class Admin::TeachersController < Admin::BaseController
  before_action :set_school
  before_action :set_teacher, only: [:show, :edit, :update, :destroy]

  # GET /schools/:school_id/teachers/new
  def new
    @teacher = @school.teachers.build
  end

  # POST /schools/:school_id/teachers
  def create
    @teacher = @school.teachers.build(teacher_params)
    if @teacher.save
      redirect_to admin_school_path(@school), success: t('defaults.message.created', item: Teacher.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: Teacher.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  # GET /schools/:school_id/teachers/:id/edit
  def edit
  end

  # PATCH /schools/:school_id/teachers/:id
  def update
    if @teacher.update(teacher_params)
      redirect_to admin_school_teacher_path(@school, @teacher), success: t('defaults.message.updated', item: Teacher.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: Teacher.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @teacher.destroy!
    redirect_to admin_school_path(@school), success: t('defaults.message.deleted', item: StudentClass.model_name.human)
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_school
    @school = School.find(params[:school_id])
  end

  def set_teacher
    @teacher = @school.teachers.find(params[:code])
  end

  # Only allow a list of trusted parameters through.
  def teacher_params
    params.require(:teacher).permit(:name, :login_id, :password, :password_confirmation)
  end
end
