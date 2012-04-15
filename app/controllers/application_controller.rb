class ApplicationController < ActionController::Base
  protect_from_forgery

  def load_company_by_handle
    @company = Company.with_handle params[:handle]
    # 404?
  end

  # Use until we have a login system
  def current_person
    @current_person ||= Person.with_handle "sirwalter"
  end

  def setup_company(company)

    @recommended = company.recommended_by? current_person
    @following = company.followed_by? current_person

    @founders = company.founders if company.founder_ids.length > 0
    @staff = company.staff if company.staff_ids.length > 0
    @investors = company.investors if company.investor_ids.length > 0

  end

end
