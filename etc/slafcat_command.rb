#Basic cat plugin

newcommand(:name => "slafcat") do |file, args|
    SLAF.log("slacat", file)
    exec("nice -n 19 /bin/cat #{args} #{file}")
end
