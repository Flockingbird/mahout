class Profile::ContactDetailViewModel
  extend Forwardable

  def_delegators :@resource, :key, :value

  def initialize(resource)
    @resource = resource
  end

  def type
    @resource.type.to_sym
  end
end
