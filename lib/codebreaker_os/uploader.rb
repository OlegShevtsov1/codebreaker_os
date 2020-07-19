# frozen_string_literal: true

require 'yaml'
module Uploader
  STORE = 'statistic.yml'
  def self.add(element)
    File.open(STORE, 'w') do |file|
      file.write(element.to_yaml)
    end
  end

  def self.get
    add([]) unless File.file?(STORE)
    YAML.load_file(STORE)
  end
end
