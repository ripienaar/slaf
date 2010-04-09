require 'syslog'
require 'slaf/whitelist'
require 'slaf/commands'

module SLAF
    #Logs an event to syslog
    def self.log(command, target)
        Syslog.open("SLAF")
        Syslog.crit("User: #{ENV["SUDO_USER"]} User id: #{ENV["SUDO_UID"]} Executing #{command} on target #{target}")
        Syslog.close
    end

    def self.command_options=(options)
        @command_options = options
    end

    def self.command_options
        @command_options
    end
end

#Defines the structure to be used when implementing additional plugins
def newcommand(options, &block)
    raise "No name given in command" unless options.include?(:name)

    command = options[:name]

    SLAF::Commands.module_eval {
        define_method("#{command}_command", &block)
    }

    SLAF::command_options ||  SLAF.command_options = {}

    if options.include?(:allow_arguments)
        SLAF::command_options[command] = options[:allow_arguments]
    else
        SLAF::command_options[command] = false
    end
end
