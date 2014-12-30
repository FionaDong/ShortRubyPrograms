require 'pry'
require 'fileutils'

Dir.chdir ARGV[0]
#get all the files and directories under current folder.
file_dir = Dir['**/*']
filenames = []
files = []
current_path = Dir.getwd + '/'
target_path = current_path + 'duplicated_files/'

#make target folder where duplicated files go to.
FileUtils.mkdir target_path unless File.directory?(target_path)

#eliminated directories from file_dir and get pure filenames and file objects.
file_dir.each do |file|
  next if File.directory?(file)
  files << file
  filenames << File.basename(file)
end

#get duplicated filenames
target_filenames = filenames.select{|file| filenames.count(file) > 1}.uniq

#traverse all the files and move filename duplicated that checked.
files.each do |file|
  FileUtils.move(current_path + file.to_s, target_path) if target_filenames.include?(File.basename(file))
end
