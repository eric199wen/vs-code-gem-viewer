require 'bundler'
require_relative './helper'
require_relative './gem_viewer'

for arg in ARGV
  # input: ContactInfo::PhoneBook
  # process the name for gem. output: ContactInfo
  gem_name = arg.to_s[0, arg.index("::") || arg.length]

  # process the name for target file. output: phone_book.rb
  target_file = demodulize(arg)
  target_file = decamelize(target_file) + '.rb'

  gem_viewer = GemViewer.new(gem_name: gem_name)
  # TODO: add option for support different editor
  gem_viewer.open_file(target_file)
end