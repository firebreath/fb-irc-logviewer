class LogFile < ActiveRecord::Base
  attr_accessible :file_date, :file_name
  belongs_to :irc_channel
  has_many :log_entries

  def self.new_from_file_name(irc_channel, file_name)
    if file_name =~ /(\d{8})/
      return LogFile.where(:irc_channel_id => irc_channel.id, :file_name => File.basename(file_name)).first_or_create!(:file_date => Date.strptime($1, '%Y%m%d'))
    end
    return nil
  end

  def self.load(file_name)
    if channel_name = IrcChannel.name_from_file(file_name)
      irc_channel = IrcChannel.where(:name => channel_name).first_or_create!
      puts "#{file_name}: loading channel #{irc_channel.name}"
      if log_file = LogFile.new_from_file_name(irc_channel, file_name)
        File.open(file_name, 'r') do |f|
          while line = f.gets
            LogEntry.new_from_line(log_file, line)
          end
        end
      else
        puts "#{file_name}: could not create a new LogFile entry?"
      end

    else
      puts "#{file_name}: could not extract channel name from file name"
    end
  end
end
