class IrcChannelsController < ApplicationController

  respond_to :xml
  def sitemap
    @irc_channels = IrcChannel.all
    respond_to do |format|
      format.xml { render 'sitemap' }
      format.any { render :text => "Only XML is currently supported."}
    end
  end

  def index
    @irc_channels = IrcChannel.all
  end

  def show
    @irc_channel = IrcChannel.find(params[:id])
    raise ActionController::RoutingError.new('Not Found') unless @irc_channel
    @log_files = @irc_channel.log_files.order('file_date desc')
  end
end
