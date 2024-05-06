class Teacher::TestNamesController < Teacher::BaseController
  before_action :set_test_name, only: [:show, :edit, :update, :destroy]

  def new
    @test_name = current_teacher_teacher.test_names.build
  end

  def create
    @test_name = current_teacher_teacher.test_names.build(test_name_params)
    if @test_name.save
      redirect_to teacher_subjects_path, success: t('defaults.message.created', item: TestName.model_name.human)
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
    if @test_name.update(test_name_params)
      redirect_to teacher_test_name_path(@test_name), success: t('defaults.message.updated', item: TestName.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: TestName.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @test_name.destroy!
    redirect_to teacher_subjects_path, success: t('defaults.message.deleted', item: TestName.model_name.human)
  end

  private

  def set_test_name
    @test_name = current_teacher_teacher.test_names.find(params[:id])
  end

  def test_name_params
    params.require(:test_name).permit(:test_name)
  end
end
