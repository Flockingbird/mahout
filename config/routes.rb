# frozen_string_literal: true

Rails.application.routes.draw do
  root 'professionals#index'

  get 'professionals/:id', as: :professional, controller: :professionals, action: :show
end
