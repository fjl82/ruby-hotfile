# frozen_string_literal: true

class Hotfile
  class Record
    ## Unticketed Point Information Record
    # ! not tested, I hope this code works at all...
    class BKI61 < Record
      def initialize(line)
        super

        segment, arrival_airport, arrival_date, arrival_time, departure_date, departure_time, equipment, reserved =
          line.scan(/
            (\d)
            ([A-Z0-9 ]{5})
            ([A-Z0-9 ]{7})
            ([\d ]{5})
            ([A-Z0-9 ]{7})
            ([\d ]{5})
            ([A-Z0-9 ]{3})
            (.{63})
          /x).flatten

        @data = {
          segment: segment.to_i,
          airport: arrival_airport.strip,
          departure_datetime:
            DateTime.parse("#{Hotfile::Date.new(departure_date).to_date} #{departure_time.strip.insert(2, ':')}"),
          arrival_datetime:
            DateTime.parse("#{Hotfile::Date.new(arrival_date).to_date} #{arrival_time.strip.insert(2, ':')}"),
          equipment: equipment.strip,
          reserved: reserved.strip
        }
      end
    end
  end
end
