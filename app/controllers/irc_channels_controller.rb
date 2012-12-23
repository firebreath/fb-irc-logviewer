class IrcChannelsController < ApplicationController
  def index
    @irc_channels = IrcChannel.all
  end

  def show
    @irc_channel = IrcChannel.find(params[:id])
    raise ActionController::RoutingError.new('Not Found') unless @irc_channel
    @log_files = @irc_channel.log_files.order('file_date desc')
  end
end
