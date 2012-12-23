class IrcChannel < ActiveRecord::Base
  attr_accessible :name
  has_many :log_files

  def self.name_from_file(file_name)
    if file_name =~ /\#([\w_]+)_\d{8}/
      return "#"+$1
    end
    return nil
  end

end
