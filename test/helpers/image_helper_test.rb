# frozen_string_literal: true

require 'test_helper'

class ImageHelperTest < ActionView::TestCase
  test 'any_image_url with a string' do
    assert_match(/edit\.png/, any_image_url('edit.png'))
  end

  test 'any_image_url with an activestorage' do
    # Simply assume we call polymorphic_url
    stub(:polymorphic_url, '/path/to/avatar.png') do
      assert_match(/avatar\.png/, any_image_url(OpenStruct.new))
    end
  end

  test 'any_image_url passes skip_pipeline along' do
    @skipped_pipeline = false

    # Hack to capture call to path_to_image and record the option passed
    def self.path_to_image(source, skip_pipeline: false)
      @skipped_pipeline = skip_pipeline
      "/#{source}"
    end

    any_image_url('edit.png', skip_pipeline: true)
    assert @skipped_pipeline
  end
end
