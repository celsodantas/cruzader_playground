Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each {|file| require file }

require "minitest/autorun"
require 'minitest/unit'
require 'mocha/mini_test'
require "minitest/reporters"
Minitest::Reporters.use!
