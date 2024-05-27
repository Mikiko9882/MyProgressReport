class SampleStudent::BaseController < ApplicationController
  before_action :check_sample_student
  layout 'sample_student/layouts/application'

  private

  def not_authenticated
    flash[:warning] = t('defaults.message.require_login')
    redirect_to root_path
  end

  def check_sample_student
    redirect_to new_sample_student_sample_student_session_path, warning: t('defaults.message.not_authorized') unless current_sample_student_sample_student
  end
end