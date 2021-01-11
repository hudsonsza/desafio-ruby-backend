# frozen_string_literal: true

class ImportsController < ApplicationController
  before_action :verify_file_params

  def cnab
    file = File.read(params[:file])
    process = CnabServices::Process.call(file)

    if process.success?
      redirect_to shops_index_url,
                  flash: { success: 'File processed successfully' }
    else
      redirect_to shops_index_url, flash: { danger: 'Error processing file' }
    end
  end

  private

  def verify_file_params
    unless params[:file].present?
      redirect_to shops_index_url,
                  flash: { warning: 'It is necessary to attach the file' }
    end
  end
end
