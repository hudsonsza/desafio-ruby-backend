# frozen_string_literal: true

module CnabServices
  class Process < ApplicationService
    def initialize(file)
      @file = file
    end

    def call
      parsed_file = CnabServices::ParseFile.call(@file)
      if parsed_file.success?
        begin
          parsed_file.payload.each do |params|
            shop = create_shop(params)
            transaction = create_transaction(shop, params)
          end
        rescue StandardError => e
          OpenStruct.new({ success?: false, error: e.message })
        else
          OpenStruct.new({ success?: true, payload: nil })
        end
      else
        OpenStruct.new({ success?: false, error: parsed_file.error })
      end
    end

    def create_shop(params)
      Shop.where(name: params[:shop_name])
          .first_or_create!(
            name: params[:shop_name],
            owner_name: params[:shop_owner_name]
          )
    end

    def create_transaction(shop, params)
      Transaction.create!(
        shop_id: shop.id,
        transaction_type: params[:transaction_type],
        cpf: params[:cpf],
        amount: params[:amount],
        card_number: params[:card_number],
        traded_at: params[:traded_at]
      )
    end
  end
end
