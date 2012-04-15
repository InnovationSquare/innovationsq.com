class ProfilesController < ApplicationController

  before_filter :load_company_by_handle, :only => :pitch_deck

  def show
    # Look for a Company First
    @company = Company.with_handle params[:handle]
    @person = Person.with_handle params[:handle] if @company.blank?

    if @person

      @title = @person.full_name
      @isotopes = @person.isotopes.desc(:created_at)

      render :action => "person"
    elsif @company

      @title = @company.name
      setup_company @company
      @isotopes = @company.isotopes.desc(:created_at)

      render :action => "company"
    else
      # 404
    end

  end

  def pitch_deck
    @title = "Pitch Deck | #{@company.name}"
    setup_company @company
    @pitch_deck = @company.pitch_deck
  end

end