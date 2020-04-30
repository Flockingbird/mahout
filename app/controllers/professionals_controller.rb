# frozen_string_literal: true

##
# Controller for public profesionals
class ProfessionalsController < ApplicationController
  layout 'public'

  def index
    @catalyst_placement = :header
    @pagy, @professionals = paged
  end

  def show
    @catalyst_placement = :aside
    @professional = resource
    @contact_details = decorate(resource.contact_details,
                                Profile::ContactDetailViewModel)
  end

  private

  def scope
    Profile.all
  end

  def resource
    scope.friendly.find(params[:id])
  end

  def resources
    scope.by_activity
  end

  def paged
    pagy(resources)
  end
end
