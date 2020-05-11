# frozen_string_literal: true

##
# View model for Profile
class ProfileViewModel
  extend Forwardable

  def_delegators(
    :@resource,
    :name,
    :bio,
    :company_name,
    :url,
    :location,
    :avatar,
    :header,
    :friendly_id
  )

  def initialize(resource)
    @resource = resource
  end

  def avatar_with_fallback(operations = {})
    if avatar.attached?
      avatar.variant(operations)
    else
      'default_avatar.png'
    end
  end
end
