module Devise
	class SmsSender
	  #Actually sends the sms token. feel free to modify and adapt to your provider and/or gem
	  def self.send_sms(phone,message)
	    sms = Moonshado::Sms.new(phone, message)
			puts message
	    return sms.deliver_sms[:stat]
	  end
	end
end
