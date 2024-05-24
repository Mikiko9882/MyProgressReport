class SampleAdmin::SampleTeachersController < SampleAdmin::BaseController
  before_action :set_sample_school
  before_action :set_sample_teacher, only: [:show, :edit, :update, :destroy]

  # GET /schools/:school_id/teachers/new
  def new
    @sample_teacher = @sample_school.sample_teachers.build
  end

  # POST /schools/:school_id/teachers
  def create
    @sample_teacher = @sample_school.sample_teachers.build(sample_teacher_params)
    if @sample_teacher.save
      redirect_to sample_admin_sample_school_path(@sample_school), success: t('defaults.message.created', item: Teacher.model_name.human)
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
    if @sample_teacher.update(sample_teacher_params)
      redirect_to sample_admin_sample_school_sample_teacher_path(@sample_school, @sample_teacher), success: t('defaults.message.updated', item: Teacher.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: Teacher.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @sample_teacher.destroy!
    redirect_to sample_admin_sample_school_path(@sample_school), success: t('defaults.message.deleted', item: StudentClass.model_name.human)
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_sample_school
    @sample_school = SampleSchool.find(params[:sample_school_id])
  end

  def set_sample_teacher
    @sample_teacher = @sample_school.sample_teachers.find(params[:code])
  end

  # Only allow a list of trusted parameters through.
  def sample_teacher_params
    params.require(:sample_teacher).permit(:name, :login_id, :password, :password_confirmation)
  end
end
