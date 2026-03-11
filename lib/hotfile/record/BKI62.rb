# frozen_string_literal: true

class Hotfile
  class Record
    ## Unticketed Point Information Record
    class BKI62 < Record
      def initialize(line)
        super

        segment, departure_airport, departure_date, departure_time, departure_terminal, arrival_airport, arrival_date,
          arrival_time, arrival_terminal, reserved =
          line.scan(/
            (\d)
            ([A-Z0-9 ]{5})
            ([A-Z0-9 ]{7})
            ([\d ]{5})
            ([A-Z0-9 ]{5})
            ([A-Z0-9 ]{5})
            ([A-Z0-9 ]{7})
            ([\d ]{5})
            ([A-Z0-9 ]{5})
            (.{51})
          /x).flatten

        departure_time = departure_time.strip
        departure_time = departure_time.insert(2, ':') if departure_time.length > 2
        departure_datetime = DateTime.parse("#{Hotfile::Date.new(departure_date).to_date} #{departure_time}") if departure_date.strip.length > 0

        arrival_time = arrival_time.strip
        arrival_time = arrival_time.insert(2, ':') if arrival_time.length > 2
        arrival_datetime = DateTime.parse("#{Hotfile::Date.new(arrival_date).to_date} #{arrival_time}") if arrival_date.strip.length > 0

        @data = {
          segment: segment.to_i,
          departure: {
            airport: departure_airport.strip,
            datetime: departure_datetime,
            terminal: departure_terminal.strip
          },
          arrival: {
            airport: arrival_airport.strip,
            datetime: arrival_datetime,
            terminal: arrival_terminal.strip
          },
          reserved: reserved.strip
        }
      end
    end
  end
end
