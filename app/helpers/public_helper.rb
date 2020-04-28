##
# Helpers for public views and templates
module PublicHelper
  def catalyst
    OpenStruct.new(Rails.application.config.catalyst)
  end

  def catalyst_placement
    @catalyst_placement
  end

  def simplified_format(text)
    sanitize(text, tags: [], attributes: []).gsub(/\n+/, '<br/>').html_safe
  end
end
