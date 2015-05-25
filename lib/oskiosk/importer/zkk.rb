require 'csv'

module Oskiosk
  module Importer
    module ZKK
      def self.import_users!(path)
        users = ::CSV.read(path, col_sep: "\t", encoding: 'UTF-8')

        users.each do |row|
          identifier = Identifier.create!(code: row[1])

          User.create!(
            name: row[0],
            identifiers: [identifier],
            tag_list: "conference:#{row[2]}",
            allow_negative_balance: true
          )
        end
      end

      def self.import_products!(path)
        products = ::CSV.read(
          path, col_sep: ',',
          encoding: 'UTF-8',
          headers: true
        )

        products.each do |row|
          next unless row[0].present?

          identifier = Identifier.create!(code: row[0])

          # the supplied tag list probably consists of the supplier, a category
          # and a subcategory
          tag_list = "supplier:#{row[4]}"
          tag_list << ",type:#{row[5]}" if row[5].present?
          tag_list << ",other:#{row[6]}" if row[6].present?

          product = Product.create!(
            name: row[1],
            identifiers: [identifier],
            tag_list: tag_list
          )

          product.pricings.create!(
            price: row[2],
            quantity: (row[3] == 'MAX_INT' ? 999_999_999 : (row[3].to_i || 0))
          )
        end
      end
    end
  end
end
