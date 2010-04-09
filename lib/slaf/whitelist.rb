module SLAF
    class Whitelist
        attr_reader :files, :plugin_config, :path

        def initialize(plugin = "")
            @files = []
            @plugin_config = {}

            File.open("/etc/slaf/slaf.cfg") do |file|
                while line = file.gets do
                    next if line =~ /^#/

                    if line =~ /^whitelist.file\s*=\s*(.+)/
                        @files.concat(Dir.glob($1.chomp))
                    elsif line =~ /plugin.#{plugin}.whitelist.file\s*=\s*(.+)/
                        @files.concat(Dir.glob($1.chomp))
                    elsif line =~ /config.plugin.#{plugin}.(.*)\s*=\s*(.*)/ && plugin != ""
                        @plugin_config[$1.to_sym] = $2.to_sym
                    elsif line =~ /path\s*=\s*(.+)/
                        @path = $1
                        ENV['PATH'] = @path
                    end
                end 
            end
        end

        def is_listed?(file)
            @files.include?(file)
        end
    end
end
