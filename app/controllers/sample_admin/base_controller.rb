class SampleAdmin::BaseController < ApplicationController
  before_action :check_sample_admin
  layout 'sample_admin/layouts/application'

  private

  def not_authenticated
    flash[:warning] = t('defaults.message.require_login')
    redirect_to root_path
  end

  def check_sample_admin
    redirect_to new_sample_admin_sample_admin_session_path, warning: t('defaults.message.not_authorized') unless current_sample_admin_sample_admin
  end
end