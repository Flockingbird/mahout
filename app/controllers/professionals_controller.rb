class ProfessionalsController < ApplicationController
  layout "public"

  def index
    @catalyst_placement = :header
    @pagy, @professionals = paged
  end

  def show
    @catalyst_placement = :aside
    @professional = resource
  end

  private

  def scope
    Profile.all
  end

  def resource
    scope.find(params[:id])
  end

  def resources
    scope.by_activity
  end

  def paged
    pagy(resources)
  end
end
