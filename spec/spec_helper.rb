require 'minitest/autorun'
require_relative '../lib/farah'

def context(*args, &block)
  describe(*args, &block)
end
