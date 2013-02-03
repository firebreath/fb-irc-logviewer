class LogFilesController < ApplicationController
  def show
    @log_file = LogFile.find(params[:id])
    raise ActionController::RoutingError.new('Not Found') unless @log_file
    @clustered_log_entries = LogEntry.cluster(@log_file.log_entries.order('id asc'))
  end
end
