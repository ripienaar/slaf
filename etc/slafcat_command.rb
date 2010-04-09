#Basic cat plugin

newcommand(:name => "slafcat") do |file, args|
    SLAF.log("slacat", file)
    exec("nice -n 19 cat #{args.join(" ")} #{file}")
end
