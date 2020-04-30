# frozen_string_literal: true

##
# Enables the postgres crypto extension used for uuidgen
class EnablePgcryptoExtension < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'pgcrypto'
  end
end
