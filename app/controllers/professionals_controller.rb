class ProfessionalsController < ApplicationController
  layout "public"

  def index
    @professionals = find_resources
  end

  private

  def resource_scope
    Profile.all
  end

  def find_resources
    resource_scope
  end
end
