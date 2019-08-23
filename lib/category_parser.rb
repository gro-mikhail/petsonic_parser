# frozen_string_literal: true

require_relative 'utils'

class CategoryParser
  include Utils

  LAST_PAGE_NUMBER_XPATH = "//ul[contains(@class, 'pagination clearfix li_fl')]//li[last()-1]//span"
  QUANTITY_PRODUCTS_XPATH = "//img[@itemprop='image']"
  PRODUCT_LINK_XPATH = "//a[@class='product_img_link product-list-category-img']"

  attr_reader :url

  def initialize(url)
    @url = url
  end

  def parse
    puts 'Идет сбор ссылок на страницы товаров. Подождите...'

    (1..last_page_number).each do |page_number|
      current_parsed_page_url = url
      current_parsed_page_url = "#{url}?p=#{page_number}" if page_number > 1
      @current_parsed_page = get_page(current_parsed_page_url)
      get_products_links
    end
    products_links
  end

  private

  def products_links
    @products_links ||= []
  end

  def last_page_number
    get_page(url).xpath(LAST_PAGE_NUMBER_XPATH).text.to_i
  end

  def quantity_products_for_page
    @current_parsed_page.xpath(QUANTITY_PRODUCTS_XPATH).size
  end

  def product_link(number_product)
    @current_parsed_page.xpath(PRODUCT_LINK_XPATH)[number_product].attributes['href'].value
  end

  def get_products_links
    (0..quantity_products_for_page - 1).each do |product_number|
      products_links.push(product_link(product_number))
    end
  end
end
