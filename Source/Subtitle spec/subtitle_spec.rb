require_relative '../Core API/Subtitle/subtitle'
require_relative '../Core API/Subtitle/subtitle_srt/subtitle_srt.rb'

	describe Subtitle do
		subtitle = nil
		before(:each) do
			subtitle = Subtitle.new
		end
		
		it "Constructs base subtitle" do
			expect(subtitle).to be_a Subtitle
		end 
		
		
		#Test no longer in use since 4.2.2015. 
		#Reason: The subtitle class should be base for all others thus it should not contain code.
		#Test Relocated in srt subtitle test.
		#it "Formats a subtitle in default format" do
		#	subtitle.id = "1"
		#	subtitle.time = "00,01,24,0124"
		#	subtitle.text = "rspec"
		#	
		#	expect(subtitle.format).to eq("1\n00,01,24,0124\nrspec\n")
		#end
	end
	
	#Srt tests are here because im considering them to be default format thus, they go for normal subtitles.
	describe SRTSubtitle do
		subtitle = nil
		before(:each) do
			subtitle = SRTSubtitle.new
		end
		
		it "Constructs a srt format subtitle" do
			expect(subtitle).to be_a SRTSubtitle
		end	
		
		it "fetches start time" do
			subtitle.time = "00:00:01,484 --> 00:00:04,791"
			expect(subtitle.start_time).to  eq "00:00:01,484"
		end 
		
		it "fetches broken time" do
			subtitle.time = "00:00:01,484"
			expect { subtitle.start_time }.to raise_error TimeFormatError
			expect { subtitle.end_time   }.to raise_error TimeFormatError
		end 
		
		it "fetches end time" do
			subtitle.time = "00:00:01,484 --> 00:00:04,791"
			expect(subtitle.end_time).to eq "00:00:04,791"
		end 
		
		it "Formats a subtitle in default format" do
			subtitle.id = "1"
			subtitle.time = "00,01,24,0124"
			subtitle.text = "rspec"
			
			expect(subtitle.format).to eq("1\n00,01,24,0124\nrspec\n")
		end
		
		it "Parses a given string into a srt subtitle" do
			subtitle.parse("1\n00:00:01,484 --> 00:00:04,791\nrspec\nrspec2\n")
			expect(subtitle.id).to eq("1")
			expect(subtitle.time).to eq("00:00:01,484 --> 00:00:04,791")
			expect(subtitle.text).to eq("rspec\nrspec2")
		end 
		
		it "Sets the start time" do
			subtitle.time = "00:00:01,484 --> 00:00:04,791"
			subtitle.set_start_time("00:00:00,000")
			expect(subtitle.time).to eq "00:00:00,000 --> 00:00:04,791"
		end 
		
		it "Sets the start time" do
			subtitle.time = "00:00:01,484 --> 00:00:04,791"
			subtitle.set_end_time("00:00:00,000")
			expect(subtitle.time).to eq "00:00:01,484 --> 00:00:00,000"
		end 
	end