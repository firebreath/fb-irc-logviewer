class LogEntry < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  attr_accessible :what, :when, :who, :log_file_id
  belongs_to :log_file

  mapping do
    indexes :id,   :index    => :not_analyzed
    indexes :log_file_id, :index => :not_analyzed
    indexes :who,  :analyzer => 'keyword'
    indexes :what, :analyzer => 'snowball'
    indexes :when, :type     => 'date'
  end

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


  # takes a time-sorted array of LogEntry records
  # returns an array of arrays of LogEntry records, clustered around who and when
  def self.cluster(entries)
    clustered = []

    prev_who = prev_when = ''
    current_cluster = []
    entries.each do |e|
      cluster = (prev_who == e.who && e.when - prev_when < 500 )

      unless cluster
        clustered.push current_cluster if current_cluster.size > 0
        current_cluster = []
      end

      current_cluster.push e

      prev_who = e.who
      prev_when = e.when
    end

    return clustered
  end
end
