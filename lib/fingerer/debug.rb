module Fingerer
  class Debug

    def self.info(message)
      puts("[#{Time.now.getutc}] INFO #{message}")
    end

    def self.error(message)
      puts("[#{Time.now.getutc}] ERROR #{message}")
    end
  end
end
