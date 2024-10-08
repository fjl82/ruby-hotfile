# frozen_string_literal: true

class Hotfile
  class Record
    ## File Header Record
    class BFH01 < Record
      def initialize(line)
        super

        bsp_id, airline_code, revision, environment, processing_date, processing_time, country, file_sequence,
            reserved =
          line.scan(/
            ([A-Z0-9]{3})
            ([A-Z0-9]{3})
            (\d{3})
            ([A-Z0-9]{4})
            (\d{6})
            (\d{4})
            ([A-Z]{2})
            (\d{6})
            (.{92})
          /x).flatten

        @data = {
          bsp_id: bsp_id,
          airline_code: airline_code,
          revision: revision.to_i,
          environment: environment,
          processed: DateTime.parse("#{Hotfile::Date.new(processing_date).to_date} #{processing_time.insert(2, ':')}"),
          country: country,
          file_sequence: file_sequence.to_i,
          reserved: reserved.strip
        }
      end
    end
  end
end
