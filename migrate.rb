#!/usr/bin/env ruby

#require 'colorize'

slash="/"
slashes="#{slash}#{slash}"

FROM_ROOT = "#{slashes}OMNINAS"
FROM_NODES = %w(Task Task_2 Task_3 Volume disk)
BACKUP_DIRNAME = "Backup" 
DEST_ROOT = "#{slashes}MIKOTOBAFUKUIN"

omni_path = ""

commands = []

def check_dirs_exists(dirs)
  dirs.each do |dir|	
    abort "\n[Directory does not exist or permission denied] \n  #{dir}" unless File.directory?(dir)
  end
  dirs
end

puts
puts "#{FROM_ROOT} -> #{DEST_ROOT}  "
FROM_NODES.each_with_index do |node, i|
  cmd = check_dirs_exists ["#{FROM_ROOT}#{slash}#{node}", "#{DEST_ROOT}#{slash}#{BACKUP_DIRNAME}"]
  puts "[#{i}] #{node} "
  commands.push cmd
end
puts "[q] quit"
puts

print "Enter Number: "
user_input = $stdin.gets.chomp

abort if user_input.downcase == "q"
abort "input wrong: #{user_input}" unless ["0","1","2","3","4"].include?(user_input)

def copy(command_tokens)
  system "cp -r #{command_tokens[0]} #{command_tokens[1]} --verbose".gsub("/", "\\")
end

copy commands[user_input.to_i]

puts "\nDone"
  
