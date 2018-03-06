class TournamentsController < ApplicationController

  def import_csv
    # save file to folder csv_uploads
    file_data = params[:upload_file]
    File.open(Rails.root.join('public', 'csv_uploads', file_data.original_filename), 'wb') do |file|
      file.write(file_data.read)
    end

    ImportCSVService.import(['public', 'csv_uploads', file_data.original_filename].join('/'))
    render json: { sucess: true }
  rescue Exception => ex
    logger.debug "Raise exception in tournament controller: #{ex}"
    render json: { success: false, errors: 'Upload file is invalid format' }
  end
end
