# frozen_string_literal: true

class Hotfile
  ## Gathers transaction information from parsed data.
  module Transaction
    def transactions
      record_groups = parse[:records].select { |x| x[:transaction].to_i.positive? }.group_by { |x| x[:transaction] }
      record_groups.each_value.map { |x| summarize_transaction(x) }
    end

    def summarize_transaction(records)
      types = records.group_by { |x| x[:code][:number] }
      {
        transaction: records.first[:transaction],
        payment: {
          total: types[30].map { |x| x[:data][:amounts][:total] }.sum,
          net: types[30].map { |x| x[:data][:amounts][:net] }.sum,
          commissionable: types[30].map { |x| x[:data][:amounts][:commissionable] }.sum
        },
        flight_schedule: flight_schedule(types[63]),
        passengers: passengers(types[65]),
        pnr: find_pnr(types[24])
      }
    end

    def flight_schedule(flight_records)
      return [] unless flight_records.respond_to?(:each)
      flight_records.map do |record|
        d = record[:data]
        {
          carrier: d[:carrier],
          flight_number: d[:flight_number],
          departure: d[:departure],
          arrival: d[:arrival],
          baggage: d[:baggage],
          status: d[:booking][:status]
        }
      end
    end

    def passengers(passenger_records)
      return [] unless passenger_records.respond_to?(:each)
      passenger_records.map do |record|
        full_name = record[:data][:name]
        surname, first_name = full_name.split('/')
        gender = first_name.end_with?('MS') || first_name.end_with?('MRS') ? :f : :m
        first_name = first_name.scan(/(.*)(MS|MR|MRS)$/).flatten.first
        type = case record[:data][:type]
                 when 'ADT' then :adult
                 when 'CHD' then :child
                 when 'INF' then :infant
                 else :unknown
               end
        {
          first_name: first_name,
          surname: surname,
          gender: gender,
          info: record[:data][:passenger_data],
          date_of_birth: record[:data][:date_of_birth],
          type: type
        }
      end
    end

    def find_pnr(records)
      records&.first&.dig(:data, :pnr)&.split('/')&.first
    end
  end
end
