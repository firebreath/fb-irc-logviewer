#
#
#

ARGV.each do |file_name|
  if File.file?(file_name)
    LogFile.load(file_name)
  else
    puts "#{file_name} does not exist or isn't a file."
  end
end
