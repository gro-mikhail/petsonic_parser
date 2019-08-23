# frozen_string_literal: true

require_relative 'utils'

class ProductParser
  include Utils

  WEIGHTS_SELECT_XPATH = "//ul[@class='attribute_radio_list']//li"
  WEIGHT_XPATH = "//span[contains(@class, 'radio_label')]"
  PRICE_XPATH = "//span[contains(@class, 'price_comb')]"
  NAME_XPATH = "//h1[contains(@itemprop, 'name')]"
  IMG_XPATH = "//img[@id='bigpic']//@src"

  attr_reader :product_page_link

  def initialize(product_page_link)
    @product_page_link = product_page_link
  end

  def parse
    puts 'Идет сбор сбор информации о товаре. Подождите...'

    if weight_count.zero?
      product_info.push(name: 'Нет в наличии', price: '?', img_url: '?')
    else
      get_product_info
    end
    product_info
  end

  private

  def product_info
    @product_info ||= []
  end

  def product_page
    @product_page ||= get_page(product_page_link)
  end

  def weight_count
    product_page.xpath(WEIGHTS_SELECT_XPATH).size
  end

  def weights_collection
    product_page.xpath(WEIGHTS_SELECT_XPATH)
  end

  def weight(weight_number)
    weights_collection[weight_number].xpath(WEIGHT_XPATH)[weight_number].text
  end

  def price(weight_number)
    weights_collection[weight_number].xpath(PRICE_XPATH)[weight_number].text.strip
  end

  def url_img
    product_page.xpath(IMG_XPATH).text
  end

  def name
    @name ||= product_page.xpath(NAME_XPATH).text
  end

  def product_name(weight_number)
    name + ' - ' + weight(weight_number)
  end

  def get_product_info
    (0..(weight_count - 1)).each do |weight_number|
      product_info.push(name: product_name(weight_number),
                        price: price(weight_number),
                        img_url: url_img)
    end
  end
end
