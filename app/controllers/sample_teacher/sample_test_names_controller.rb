class SampleTeacher::SampleTestNamesController < SampleTeacher::BaseController
  before_action :set_sample_test_name, only: [:show, :edit, :update, :destroy]

  def new
    @sample_test_name = current_sample_teacher_sample_teacher.sample_test_names.build
  end

  def create
    @sample_test_name = current_sample_teacher_sample_teacher.sample_test_names.build(sample_test_name_params)
    if @sample_test_name.save
      redirect_to sample_teacher_sample_subjects_path, success: t('defaults.message.created', item: TestName.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: TestName.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @sample_test_name.update(sample_test_name_params)
      redirect_to sample_teacher_sample_test_name_path(@sample_test_name), success: t('defaults.message.updated', item: TestName.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: TestName.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @sample_test_name.destroy!
    redirect_to sample_teacher_sample_subjects_path, success: t('defaults.message.deleted', item: TestName.model_name.human)
  end

  private

  def set_sample_test_name
    @sample_test_name = current_sample_teacher_sample_teacher.sample_test_names.find(params[:id])
  end

  def sample_test_name_params
    params.require(:sample_test_name).permit(:test_name)
  end
end
