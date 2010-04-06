#Basic less plugin

newcommand(:name => "slafless") do |file, operands|
    ENV["LESSSECURE"] = "1"
    SLAF.log("slaless", file)
    exec("nice -n 19 /usr/bin/less #{operands.join(" ")} #{file}")
end
