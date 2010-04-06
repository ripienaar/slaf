module SLAF
    class Commands
        def initialize(command)
            @command = command

            load_command
        end
        
        def execute(file, operands)
            list = SLAF::Whitelist.new(@command)
            if list.is_listed?(file)
                send("#{@command}_command", file, operands)
            else
                puts "Could not execute #{@command} on #{file}. #{file} was not found in the whitelist."
            end
        end    

        def load_command
            command_file = "/etc/slaf/#{@command}_command.rb"
            raise "No command script found for #{@command}" unless File.exist?(command_file)
            load command_file
        end
        
        def show_whitelist(command)
            puts "Displaying whitelist for command #{command}"
            puts "-------------------------------------------"
            puts SLAF::Whitelist.new(command).files
            puts "-------------------------------------------"
            puts "End of whitelist"
        end
    end
end
