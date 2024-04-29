class Admin::SchoolsController < Admin::BaseController
  before_action :set_school, only: [:show, :edit, :update, :destroy]

  def index
    @q = School.ransack(params[:q])
    @schools = @q.result(distinct: true).order(created_at: :asc)
  end
    
  # 新しい学校を作成するためのフォームを表示するアクション
  def new
    @school = School.new
    @school.generate_unique_code
  end
    
  # 新しい学校を作成するアクション
  def create
    @school = current_admin_admin.schools.build(school_params)
    if @school.save
      redirect_to admin_schools_path, success: t('defaults.message.created', item: School.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: School.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end
    
  # 学校の詳細を表示するアクション
  def show
    @school = School.find(params[:id])
  end
    
  # 学校を編集するためのフォームを表示するアクション
  def edit
    @school = current_admin_admin.schools.find(params[:id])
  end
    
  # 学校を更新するアクション
  def update
    @school = current_admin_admin.schools.find(params[:id])
    if @school.update(school_params)
      redirect_to admin_school_path(@school), success: t('defaults.message.updated', item: School.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: School.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end
    
  # 学校を削除するアクション
  def destroy
    @school = current_admin_admin.schools.find(params[:id])
    @school.destroy!
    redirect_to admin_schools_path, success: t('defaults.message.deleted', item: School.model_name.human)
  end
    
  private

  def set_school
    @school = School.find(params[:id])
  end
    
  def school_params
    params.require(:school).permit(:name, :address, :phone_number, :email, :website)
  end
end
