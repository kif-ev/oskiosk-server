require 'csv'

module Oskiosk
  module Importer
    module Ilmenau
      def self.import_kiffel!(path)
        users = ::CSV.read(path, col_sep: ',', encoding: 'UTF-8')

        users.each do |row|
          identifier = Identifier.create!(code: row[1])

          User.create!(
            name: row[0],
            identifiers: [identifier],
            tag_list: (row[2].present? ? "uni:#{row[2]} " : ""),
            allow_negative_balance: true
          )
        end
      end

      def self.import_orga!(path)
        users = ::CSV.read(path, col_sep: ',', encoding: 'UTF-8')

        users.each do |row|
          identifier = Identifier.create!(code: row[1])

          User.create!(
            name: row[0],
            identifiers: [identifier],
            tag_list: (row[2].present? ? "uni:#{row[2]} " : "") + "orga",
            allow_negative_balance: true
          )
        end
      end

      def self.import_anon!(path)
        users = ::CSV.read(path, col_sep: ',', encoding: 'UTF-8')

        users.each do |row|
          identifier = Identifier.create!(code: row[0])

          User.create!(
            name: "Anon",
            identifiers: [identifier],
            tag_list: "",
            allow_negative_balance: false
          )
        end
      end

      def self.import_products!(path)
        products = ::CSV.read(
          path, col_sep: ',',
          encoding: 'UTF-8'
        )

        products.each do |row|
          identifier = Identifier.create!(code: row[1])

          tag_list = (row[3].present? ? "type:#{row[3]}" : "")

          product = Product.create!(
            name: row[0],
            identifiers: [identifier],
            tag_list: tag_list
          )

          product.pricings.create!(
            price: row[2],
            quantity: 999_999_999
          )
        end
      end
    end
  end
end
