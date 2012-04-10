class ProfilesController < ApplicationController

  def show
    # Look for a Company First
    @company = Company.with_handle params[:handle]
    @person = Person.with_handle params[:handle] if @company.blank?

    if @person
      render :action => "person"
    elsif @company
      @title = @company.name
      render :action => "company"
    else
      # 404
    end
    
  end

end