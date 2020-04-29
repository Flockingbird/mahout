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

  def formatted_contact_detail_value(contact_detail)
    case contact_detail.type
    when :email    then mail_to(contact_detail.value)
    when :phone    then link_to(contact_detail.value, "tel:#{contact_detail.value}")
    when :twitter  then link_to("@#{contact_detail.value}", "https://twitter.com/#{contact_detail.value}")
    when :facebook then link_to(contact_detail.value, "https://www.facebook.com/#{contact_detail.value}")
    when :linkedin then link_to(contact_detail.value, "https://linkedin.com/#{contact_detail.value}")
    else contact_detail.value
    end
  end

  def formatted_contact_detail_icon(contact_detail)
    case contact_detail.type
    when :email    then '<i class="fas fa-envelope"></i>'
    when :phone    then '<i class="fas fa-phone"></i><i class="fas fa-sms"></i>'
    when :twitter  then '<i class="fab fa-twitter"></i>'
    when :facebook then '<i class="fab fa-facebook"></i>'
    when :linkedin then '<i class="fab fa-linkedin"></i>'
    else ''
    end
  end
end
