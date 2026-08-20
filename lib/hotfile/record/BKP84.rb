# frozen_string_literal: true

class Hotfile
  class Record
    ## Form of Payment Record
    class BKP84 < Record
      def initialize(line)
        super

        date_of_issue, transaction_number, payment_type, amount, account, expiry, extend_code, approval_code,
            invoice_number, invoice_date, remittance_amount, verification, reserved, currency =
          line.scan(/
            (\d{6})
            (\d{6})
            ([A-Z0-9 ]{10})
            (\d{10}.)
            (.{19})
            ([A-Z0-9 ]{4})
            ([A-Z0-9 ]{2})
            ([A-Z0-9 ]{6})
            ([A-Z0-9 ]{14})
            ([\d ]{6})
            (\d{10}.)
            (.)
            (.{23})
            ([A-Z0-9]{4})
          /x).flatten

        @data = {
          currency: currency.strip,
          date_of_issue: Hotfile::Date.new(date_of_issue).to_date,
          transaction_number: Hotfile::Integer.new(transaction_number).to_i,
          payment_type: payment_type.strip,
          amount: Hotfile::Integer.new(amount).to_i,
          account: account.strip,
          expiry: expiry.strip,
          extend_code: extend_code.strip,
          approval_code: approval_code.strip,
          invoice_number: invoice_number.strip,
          invoice_date: Hotfile::Date.new(invoice_date).to_date,
          remittance_amount: Hotfile::Integer.new(remittance_amount).to_i,
          verification: verification.strip,
          reserved: reserved.strip
        }
      end
    end
  end
end
