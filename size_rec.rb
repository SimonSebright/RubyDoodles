def size_rec(dir, min_digits = 10, report_to = 3, level = 0)
	padding = " " * level
	begin
		stuff = Dir.entries(dir)
		sizes = stuff.map{|name|
			if(name == ".") then 
				0
			elsif(name == "..") then
				0
			elsif name == "Application Data" and dir.include? "Application Data" then
				puts "ignore Application Data in " + dir
				0
			elsif name == "Anwendungsdaten" and dir.include? "Anwendungsdaten" then
				puts "ignore Anwendungsdaten in " + dir
				0
			else
				full = dir + "\\" + name
				if(File.directory?(full)) then
					size_rec(full, min_digits, report_to, level + 1)
				else
					File.size(full)
				end
			end
		}
		sum = sizes.sum
		digits = sum.digits.count
		
		if(level < report_to and digits >= min_digits) then
			puts padding + digits.to_s + " " + sum.to_s + " " + dir
		end
		return sum
	rescue StandardError => e
		# E.g. access denied
		puts e.message; 
		# puts e.backtrace.inspect
		# puts "rescued!"
		0;
	end
end