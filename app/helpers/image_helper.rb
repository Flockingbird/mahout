# frozen_string_literal: true

##
# Helpers for public views and templates
module ImageHelper
  def any_image_url(source, options = {})
    skip_pipeline = options.delete(:skip_pipeline)

    if source.is_a?(Symbol) || source.is_a?(String)
      URI.join(
        root_url,
        path_to_image(source, skip_pipeline: skip_pipeline)
      ).to_s
    else
      polymorphic_url(source)
    end
  end
end
