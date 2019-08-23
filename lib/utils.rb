# frozen_string_literal: true

require 'nokogiri'
require 'curb'

module Utils
  def get_page(page_url)
    url = Curl.get(page_url) do |http|
      http.headers['User-Agent'] = 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:68.0) Gecko/20100101 Firefox/68.0'
    end
    Nokogiri::HTML(url.body)
  end
end
