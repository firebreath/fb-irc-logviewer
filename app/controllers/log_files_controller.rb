class LogFilesController < ApplicationController
  def show
    @log_file = LogFile.find(params[:id])
    raise ActionController::RoutingError.new('Not Found') unless @log_file
    @log_entries = @log_file.log_entries
  end
end
