# frozen_string_literal: true

Rails.application.routes.draw do
  get  'shops/:shop_id/transactions' => 'transactions#index',
       as: :transactions_index
  post 'imports/cnab' => 'imports#cnab', as: :import_cnab
  root 'shops#index', as: :shops_index
end
