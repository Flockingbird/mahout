##
# Helpers for public views and templates
module PublicHelper
  def catalyst
    OpenStruct.new(Rails.application.config.catalyst)
  end
end
