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
            allow_negative_balance: false
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
          tags = row[4].split(',').map(&:strip)
          tag_list = "supplier:#{tags[0]}"
          tag_list << ",category:#{tags[1]}" if tags[1].present?
          tag_list << ",subcategory:#{tags[2]}" if tags[2].present?

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
