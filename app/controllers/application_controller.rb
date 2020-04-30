# frozen_string_literal: true

##
# Bas  Controller for all controllers
class ApplicationController < ActionController::Base
  include Pagy::Backend

  ## TODO: When resource is a model, decorate a single item instead of mapping
  def decorate(resource, klass)
    resource.map { |object| klass.new(object) }
  end
end
