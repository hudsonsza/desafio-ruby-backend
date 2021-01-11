# frozen_string_literal: true

class ShopsController < ApplicationController
  before_action :set_shop, only: [:show]

  def index
    @shops = Shop.all.order(:name)
  end

  def show; end

  private

  def set_store
    @shop = Shop.includes(:transactions).find(params[:id])
  end
end
