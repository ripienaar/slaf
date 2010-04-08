#!/usr/bin/ruby
# A secure access framework that allows admins to mimmic common Linux commands by implementing simple plugins. 
# Access to files are controlled by whitelisting files and directories in /etc/slaf/slaf.cfg.
#
# Examples of plugins can be found in /etc/slaf/
# 
# SLAF plugins can log access events directly to syslog by using the Slaf.log(plugin, target file).

$LOAD_PATH << "lib"

require 'slaf'

file = nil
operands = []
show_white = false

plugin = File.basename($0)
command = SLAF::Commands.new(plugin)

ARGV.each do |arg|
    if arg == "-h" || arg == "--help"
        puts
        puts "Secure Log Access Framework."
        puts "----------------------------"
        puts "[Commandname] --whitelist | Display a list of all files whitelisted for [Commandname]"
        puts "[Commandname] [target]    | Execute [Commandname] on [target]"
        puts
        exit 0
    
    elsif arg =~ /[<>`|]/
        puts "Arguments my not contain \"<\", \">\", \"|\" or \"`\" characters."
        exit 1

    elsif arg =~ /\// && file == nil
        file = arg

    elsif arg =~/\//
        puts "#{plugin} may only be executed on one file at a time"
        exit 1

    elsif arg =~ /^-w/ || arg =~ /^--whitelist/
        show_white = true

    elsif SLAF.command_options[plugin] == false
        unless arg =~/^-/
            operands << arg
        else
            puts "#{arg} not added to arugments list. - arguments are disabled for #{plugin}"
        end
    else
        operands << arg
    end
end

if show_white
    command.show_whitelist(plugin)
elsif ARGV.size != 0
    command.execute(file, operands)
elsif ARGV.size == 0
    puts "Missing paramater. Use with -h or --help for more information."
end
