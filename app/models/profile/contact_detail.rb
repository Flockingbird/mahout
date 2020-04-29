##
# Profile::ContactDetail
#
class Profile::ContactDetail
  include ActiveModel::Validations

  attr_reader :key, :value, :type

  validates_presence_of :key
  validates_presence_of :value
  validates_presence_of :type

  def initialize(key: '', value: '', type: '')
    @key = key
    @value = value
    @type = type
  end
end
