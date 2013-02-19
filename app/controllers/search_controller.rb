class SearchController < ApplicationController
  def search
    @irc_channel = IrcChannel.find(params[:irc_channel_id])
    raise ActionController::RoutingError.new('IrcChannel required for search') unless @irc_channel

    page = params[:page] || 1
    q = params[:query]
    @results = LogEntry.search(page: page, per_page: 30, :load => true)do
      query { string q } if q.present?
    end
  end
end
