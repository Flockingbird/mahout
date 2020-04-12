class ProfessionalsController < ApplicationController
  layout "public"

  def index
    @pagy, @professionals = paged
  end

  private

  def scope
    Profile.all
  end

  def resources
    scope
  end

  def paged
    pagy(resources)
  end
end
