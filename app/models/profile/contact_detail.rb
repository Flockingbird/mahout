# frozen_string_literal: true

class Profile
  ##
  # Profile::ContactDetail model used to validate contact details
  class ContactDetail
    include ActiveModel::Validations

    MAX_KEY_LENGTH = 100
    MAX_VALUE_LENGTH = 300
    ALLOWED_TYPES = %w[address email facebook linkedin phone twitter].freeze

    attr_reader :key, :value, :type

    validates :key, presence: true, length: { maximum: MAX_KEY_LENGTH }
    validates :value, presence: true, length: { maximum: MAX_VALUE_LENGTH }
    validates :type, presence: true, inclusion: { in: ALLOWED_TYPES }

    def initialize(key: '', value: '', type: '')
      @key = key
      @value = value
      @type = type
    end
  end
end
