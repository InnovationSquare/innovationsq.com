class ApplicationController < ActionController::Base
  protect_from_forgery

  def load_company_by_handle
    @company = Company.with_handle params[:handle]
    # 404?
  end

  # Use until we have a login system
  def current_person
    @current_person ||= Person.with_handle "cw"
  end

end
