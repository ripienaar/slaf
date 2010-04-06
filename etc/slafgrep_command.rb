#Basic grep plugin
newcommand(:name => "slafgrep", :allow_arguments => true) do |file, args|
    SLAF.log("slagrep", file)
    exec(" nice -n 19 /bin/grep #{args} #{file}")
end
