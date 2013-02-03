class LogEntry < ActiveRecord::Base
  attr_accessible :what, :when, :who, :log_file_id
  belongs_to :log_file

  # [18:56:33] <taxilian_away> jakepetroules: yes, that is correct
  def self.new_from_line(log_file, line)
    return unless log_file && line
    line.chomp!
    begin
      regexp = /\[([\d\:]+)\] <(.*?)> /
      if line =~ regexp
        line_time = $1
        line_who  = $2
        line_what = line.gsub(regexp, '')

        file_date = log_file.file_date.strftime('%Y%m%d')
        log_when = Time.strptime("#{file_date} #{line_time}", "%Y%m%d %H:%M:%S")

        log_file.log_entries.where(:when => log_when, :who => line_who, :what => line_what).first_or_create!
      end
    rescue Exception => e
      puts "#{log_file.file_name}: unable to load: #{line}\nmessage:#{e.to_s}"
    end
  end
end
