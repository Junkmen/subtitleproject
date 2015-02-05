class TimeFormatError < StandardError
end
class Subtitle
    attr_accessor :id
	attr_accessor :time
	attr_accessor :text
	
	def format() end
	
	def parse(text) end
	
	def start_time() end
	
	def end_time() end

	def set_start_time(s_time) end
	
	def set_end_time(e_time) end
end