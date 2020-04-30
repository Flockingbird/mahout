# frozen_string_literal: true

##
# Profile::ContactDetail
#
class Profile::ContactDetail
  include ActiveModel::Validations

  MAX_KEY_LENGTH = 100
  MAX_VALUE_LENGTH = 300
  ALLOWED_TYPES = %w[address email facebook linkedin phone twitter].freeze

  attr_reader :key, :value, :type

  validates_presence_of :key
  validates_presence_of :value
  validates_presence_of :type
  validates_length_of :key, maximum: MAX_KEY_LENGTH
  validates_length_of :value, maximum: MAX_VALUE_LENGTH
  validates_inclusion_of :type, in: ALLOWED_TYPES

  def initialize(key: '', value: '', type: '')
    @key = key
    @value = value
    @type = type
  end
end
