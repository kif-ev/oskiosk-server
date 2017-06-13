require 'csv'

module Oskiosk
  module Importer
    module Regensburg
      def self.import_users!(path)
        users = ::CSV.read(
          path,
          col_sep: ';',
          encoding: 'UTF-8',
          headers: true
        )

        users.each do |row|
          identifier = Identifier.create!(code: row['Barcode'])

          User.create!(
            name: row['Anzeigename'],
            identifiers: [identifier],
            tag_list: "conference:#{row['Konferenz']}",
            allow_negative_balance: (row['payment'] == 'postpaid')
          )
        end
      end
    end
  end
end
