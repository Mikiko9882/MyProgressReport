class SampleTeacher::BaseController < ApplicationController
  before_action :check_sample_teacher
  layout 'sample_teacher/layouts/application'

  private

  def not_authenticated
    flash[:warning] = t('defaults.message.require_login')
    redirect_to root_path
  end

  def check_sample_teacher
    redirect_to new_sample_teacher_sample_teacher_session_path, warning: t('defaults.message.not_authorized') unless current_sample_teacher_sample_teacher
  end
end