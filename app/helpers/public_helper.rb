# frozen_string_literal: true

##
# Helpers for public views and templates
module PublicHelper
  def title
    content_for(:title) || ''
  end

  def catalyst
    OpenStruct.new(Rails.application.config.catalyst)
  end

  ##
  # Simplified format of a user-generated text.
  #
  # This calls sanitize to remove all (unsafe) HTML and then replaces newlines
  # with break tags.
  #
  # rubocop:disable Rails/OutputSafety
  # We use sanitize to remove all HTML so it is safe.
  def simplified_format(text)
    sanitize(text, tags: [], attributes: []).gsub(/\n+/, '<br/>').html_safe
  end
  # rubocop:enable Rails/OutputSafety

  def formatted_contact_detail_value(contact_detail)
    case contact_detail.type
    when :email
      mail_to(contact_detail.value)
    when :phone
      link_to(contact_detail.value, "tel:#{contact_detail.value}")
    when :twitter
      link_to("@#{contact_detail.value}", "https://twitter.com/#{contact_detail.value}")
    when :facebook
      link_to(contact_detail.value, "https://www.facebook.com/#{contact_detail.value}")
    when :linkedin
      link_to(contact_detail.value, "https://linkedin.com/#{contact_detail.value}")
    else contact_detail.value
    end
  end

  ##
  # Renders an icon with font-awesome based on a contact_detailt item type
  #
  # rubocop:disable Rails/OutputSafety
  # We craft only hardcoded html and use no user-input, so the generated HTML
  # can be considered safe.
  def formatted_contact_detail_icon(contact_detail)
    case contact_detail.type
    when :email    then '<i class="fas fa-envelope"></i>'
    when :phone    then '<i class="fas fa-phone"></i><i class="fas fa-sms"></i>'
    when :twitter  then '<i class="fab fa-twitter"></i>'
    when :facebook then '<i class="fab fa-facebook"></i>'
    when :linkedin then '<i class="fab fa-linkedin"></i>'
    else ''
    end.html_safe
  end
  # rubocop:enable Rails/OutputSafety
end
