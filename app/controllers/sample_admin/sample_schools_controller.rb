class SampleAdmin::SampleSchoolsController < SampleAdmin::BaseController
  before_action :set_sample_school, only: [:show, :edit, :update, :destroy]

  def index
    @sample_schools = SampleSchool.order(created_at: :asc)
  end
    
  # 新しい学校を作成するためのフォームを表示するアクション
  def new
    @sample_school = SampleSchool.new
    @sample_school.generate_unique_code
  end
    
  # 新しい学校を作成するアクション
  def create
    @sample_school = current_sample_admin_sample_admin.sample_schools.build(sample_school_params)
    if @sample_school.save
      redirect_to sample_admin_sample_schools_path, success: t('defaults.message.created', item: School.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: School.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end
    
  # 学校の詳細を表示するアクション
  def show
    @sample_school = SampleSchool.find(params[:id])
  end
    
  # 学校を編集するためのフォームを表示するアクション
  def edit
    @sample_school = current_sample_admin_sample_admin.sample_schools.find(params[:id])
  end
    
  # 学校を更新するアクション
  def update
    @sample_school = current_sample_admin_sample_admin.sample_schools.find(params[:id])
    if @sample_school.update(sample_school_params)
      redirect_to sample_admin_sample_school_path(@sample_school), success: t('defaults.message.updated', item: School.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: School.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end
    
  # 学校を削除するアクション
  def destroy
    @sample_school = current_sample_admin_sample_admin.sample_schools.find(params[:id])
    @sample_school.destroy!
    redirect_to sample_admin_sample_schools_path, success: t('defaults.message.deleted', item: School.model_name.human)
  end
    
  private

  def set_sample_school
    @sample_school = SampleSchool.find(params[:id])
  end
    
  def sample_school_params
    params.require(:sample_school).permit(:name, :address, :phone_number, :email, :website)
  end
end
