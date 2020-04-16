class Profile < ApplicationRecord
  CD_ENTRIES_MAX = 255
  CD_REQUIRED_ATTRS = %w(key type value)

  has_one_attached :avatar
  has_one_attached :header
  validate :validate_contact_details_entries

  # add last_activity_at as create timestamp
  def self.timestamp_attributes_for_create
    super + ['last_activity_at']
  end

  def self.by_activity
    order(last_activity_at: :desc)
  end

  private

  def validate_contact_details_entries
    return if contact_details.blank?
    limit_contact_details_entries
    format_contact_details_entries
  end

  def format_contact_details_entries
    # Must be array,
    # all required keys must be set
    # all entries must have values
    wrong_format = (!contact_details.is_a?(Array) ||
      contact_details.any? {|d| d.keys.sort != CD_REQUIRED_ATTRS } ||
      contact_details.any? {|d| d.values.any?(&:blank?) })

    errors.add(:contact_details, :wrong_format) if wrong_format
  end

  def limit_contact_details_entries
    if contact_details.length > CD_ENTRIES_MAX
      errors.add(:contact_details, :too_many, count: 255)
    end
  end
end
