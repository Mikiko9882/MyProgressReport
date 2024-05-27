# frozen_string_literal: true

class SampleTeachers::SessionsController < Devise::SessionsController
  before_action :set_sample_school, only: [:new, :create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  protected

  def after_sign_in_path_for(resource)
    sample_teacher_root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    new_sample_teacher_sample_teacher_session_path
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  private

  def set_sample_school
    @sample_school = SampleSchool.find_by(code: params[:school_code])
    unless @sample_school
      flash[:alert] = "学校が見つかりませんでした"
      redirect_to root_path
    end
  end
end
