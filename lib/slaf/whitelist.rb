module SLAF
    class Whitelist
        attr_reader :files, :plugin_config

        def initialize(plugin = "")
            @files = []
            @plugin_config = {}

            File.open("/etc/slaf/slaf.cfg") do |file|
                while s = file.gets do
                    if s =~ /^whitelist.file = (.+)/
                        @files.concat(Dir.glob($1.chomp))
                    elsif s =~ /plugin.#{plugin}.whitelist.file = (.+)/
                        @files.concat(Dir.glob($1.chomp))
                    elsif s =~ /config.plugin.#{plugin}.(.*) = (.*)/ && plugin != ""
                        @plugin_config[$1.to_sym] = $2.to_sym
                    end
                end 
            end
        end

        def is_listed?(file)
            @files.include?(file)
        end
    end
end
