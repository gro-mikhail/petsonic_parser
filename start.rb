# frozen_string_literal: true

require_relative 'lib/petsonic_parser_app'

url = ARGV[0]
file_name = ARGV[1]

puts 'Старт!'
PetsonicParserApp.new(url, file_name).run
