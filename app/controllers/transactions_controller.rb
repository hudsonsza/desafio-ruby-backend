# frozen_string_literal: true

class TransactionsController < ApplicationController
  before_action :set_shop, only: [:index]

  def index
    @transactions = @shop.transactions
  end

  private

  def set_shop
    @shop = Shop.includes(:transactions).find(params[:shop_id])
  end
end
