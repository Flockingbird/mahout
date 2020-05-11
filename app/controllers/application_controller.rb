# frozen_string_literal: true

##
# Bas  Controller for all controllers
class ApplicationController < ActionController::Base
  include Pagy::Backend

  def decorate(resource, klass)
    if resource.respond_to?(:map)
      resource.map { |object| klass.new(object) }
    else
      klass.new(resource)
    end
  end
end
