class SampleAdmin::SampleSchoolsController < SampleAdmin::BaseController

  def index
    @sample_schools = SampleSchool.order(created_at: :asc)
  end
    
    
  # 学校の詳細を表示するアクション
  def show
    @sample_school = SampleSchool.find(params[:id])
  end
    
  private

    
  def sample_school_params
    params.require(:sample_school).permit(:name, :address, :phone_number, :email, :website)
  end
end
