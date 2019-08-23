# frozen_string_literal: true

require 'csv'

class CSVParsedInfoWriter
  attr_reader :products_info, :file_name

  def initialize(products_info, file_name)
    @products_info = products_info
    @file_name = file_name
  end

  def write
    puts 'Идет запись в файл.'
    CSV.open("data/#{file_name}.csv", 'w') do |csv|
      csv << %w[Название Цена Изображение]
      products_info.each do |product_info|
        csv << [product_info[:name],
                product_info[:price],
                product_info[:img_url]]
      end
      puts 'Готово!'
    end
  end
end
