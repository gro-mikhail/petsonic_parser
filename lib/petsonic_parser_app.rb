# frozen_string_literal: true

require_relative 'category_parser'
require_relative 'product_parser'
require_relative 'csv_parsed_info_writer'

class PetsonicParserApp
  attr_reader :url, :file_name

  def initialize(url, file_name)
    @url = url
    @file_name = file_name
  end

  def run
    CSVParsedInfoWriter.new(products_info, file_name).write
  end

  private

  def products_links
    CategoryParser.new(url).parse
  end

  def products_info
    products_links.inject([]) do |products, link|
      sleep(1..3)
      products | ProductParser.new(link).parse
    end
  end
end
