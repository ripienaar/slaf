#Basic less plugin

newcommand(:name => "slafless") do |file, args|
    ENV["LESSSECURE"] = "1"
    SLAF.log("slaless", file)
    exec("nice -n 19 /usr/bin/less #{args.join(" ")} #{file}")
end
