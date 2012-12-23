class LogEntry < ActiveRecord::Base
  attr_accessible :what, :when, :who, :log_file_id
  belongs_to :log_file

  # [18:56:33] <taxilian_away> jakepetroules: yes, that is correct
  def self.new_from_line(log_file, line)
    return unless line
    begin
      if line =~ /\[([\d\:]+)\] <(.*?)>/
        line_time = $1
        line_who  = $2

        file_date = log_file.file_date.strftime('%Y%m%d')
        log_when = Date.strptime("#{file_date} #{line_time}", "%Y%m%d %H:%M:%S")
        LogEntry.create!(:log_file_id => log_file.id,  :when => log_when, :who => line_who, :what => line)
      end
    rescue Exception => e
      puts "#{log_file.file_name}: unable to load: #{line}\nmessage:#{e.to_s}"
    end
  end
end
