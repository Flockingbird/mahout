# frozen_string_literal: true

class Profile < ApplicationRecord
  extend FriendlyId

  CD_ENTRIES_MAX = 255

  has_one_attached :avatar
  has_one_attached :header
  # Ensure formatted correct:
  # [ { "key": "Home",
  #     "type": "phone",
  #     "value": +420 (252) 658-3548 },
  #   { "key": "Work",
  #     "type": "phone",
  #     "value": 773-384-0939 },
  # ]
  validate :validate_contact_details_entries

  friendly_id :slug_candidates, use: :slugged

  # add last_activity_at as create timestamp
  def self.timestamp_attributes_for_create
    super + ['last_activity_at']
  end

  def self.by_activity
    order(last_activity_at: :desc)
  end

  def contact_details
    return [] unless self[:contact_details].is_a?(Array)

    self[:contact_details].map do |cd|
      if cd.is_a?(Profile::ContactDetail)
        cd
      else
        Profile::ContactDetail.new(cd.symbolize_keys)
      end
    end
  end

  private

  def slug_candidates
    [
      :name,
      %i[name location]
    ]
  end

  def validate_contact_details_entries
    return if self[:contact_details].blank?

    limit_contact_details_entries
    format_contact_details_entries
    valid_contact_details_entries
  end

  def format_contact_details_entries
    return if self[:contact_details].is_a?(Array)

    errors.add(:contact_details, :wrong_format)
  end

  def valid_contact_details_entries
    return if contact_details.all?(&:valid?)

    errors.add(:contact_details, :wrong_format)
  end

  def limit_contact_details_entries
    if contact_details.length > CD_ENTRIES_MAX
      errors.add(:contact_details, :too_many, count: 255)
    end
  end
end
