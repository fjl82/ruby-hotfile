# frozen_string_literal: true

class Hotfile
  class Record
    ## Itinerary Data Segment Record
    class BKI63 < Record
      def initialize(line)
        super

        segment, stopover, not_valid_before, not_valid_after, departure_airport, arrival_airport, carrier, cabin,
            flight_number, booking_designator, departure_date, departure_time, booking_status, baggage, fare_basis,
            ff_ref, fare_class, change_of_gauge, equipment, reserved =
          line.scan(/
            (\d)
            ([A-Z ])
            ([A-Z0-9 ]{5})
            ([A-Z0-9 ]{5})
            ([A-Z0-9 ]{5})
            ([A-Z0-9 ]{5})
            ([A-Z0-9 ]{3})
            ([A-Z0-9 ])
            ([A-Z0-9 ]{5})
            ([A-Z ]{2})
            ([A-Z0-9 ]{7})
            ([A-Z0-9 ]{5})
            ([A-Z ]{2})
            ([A-Z0-9 ]{3})
            (.{15})
            ([A-Z0-9 ]{20})
            ([A-Z0-9 ]{3})
            ([A-Z0-9 ])
            ([A-Z0-9 ]{3})
            (.{4})
          /x).flatten

        departure_datetime = DateTime.parse("#{Hotfile::Date.new(departure_date).to_date} #{departure_time.strip.insert(2, ':') if departure_time.strip.length > 1}") if departure_date.strip.length > 0
        @data = {
          segment: segment.to_i,
          carrier: carrier.strip,
          flight_number: flight_number.strip,
          departure: {
            airport: departure_airport.strip,
            datetime: departure_datetime
          },
          stopover: stopover.strip,
          arrival: {
            airport: arrival_airport.strip
          },
          validity: {
            not_before: Hotfile::Date.new(not_valid_before).to_date,
            not_after: Hotfile::Date.new(not_valid_after).to_date
          },
          cabin: cabin.strip,
          baggage: baggage.strip,
          equipment: equipment.strip,
          booking: {
            designator: booking_designator.strip,
            status: booking_status.strip,
            frequent_flyer_ref: ff_ref.strip,
            fare_basis: fare_basis.strip,
            fare_class: fare_class.strip,
            change_of_gauge: change_of_gauge.strip
          },
          reserved: reserved.strip
        }
      end
    end
  end
end
