require_relative '../subtitle'

class SRTSubtitle < Subtitle
	
	#Returns a formatted string in the srt format.
	def format() 
		id + "\n" + time + "\n" + text + "\n"
	end
	
	#Parses a string and force writes it without any error checking, thus the string should be formatted and legitimate.
	def parse(text)
		text = text.split("\n")
		#Called through self because they are not considered in scope, even if they are inherited.
		self.id = text[0]
		self.time = text[1]
		self.text = text[2..-1].join("\n")
	end
	
	#Checks if a given string is a legitimate time in the srt format:
	#Legitimate format of srt time is: 00:00:01,484 --> 00:00:04,791 thus the split time length should == 2.
	def isTimeLegitimate(time)
		time.split(" --> ").size == 2
	end

	#Parses the time attribute and returns the time of the subtitle start.
	def start_time()
		raise TimeFormatError if not isTimeLegitimate(time) 
		time.split(" --> ").first
	end
	
	#Parses the time attribute and returns the time of the subtitle end.
	def end_time()
		raise TimeFormatError if not isTimeLegitimate(time) 
		time.split(" --> ").last
	end
	
	#Sets the starting time of the subtitle.
	def set_start_time(s_time)
		raise TimeFormatError if not isTimeLegitimate(time) 
		self.time = [s_time, self.time.split(" --> ").last].join(" --> ")
	end
	
	#Sets the ending time of the subtitle.
	def set_end_time(e_time)
		raise TimeFormatError if not isTimeLegitimate(time) 
		self.time = [self.time.split(" --> ").first, e_time].join(" --> ")
	end
end 