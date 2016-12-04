require_relative './spec_helper'

module Runners
  include Farah::Helpers

  class Foo < Farah::Runner
    def bar(sym)
      success!('success!') if sym == :bar
      failure!('failure!')
    end

    def qux(value)
      value
    end
  end
end

class Controller
  include Runners

  attr_reader :success, :failure

  def initialize
    @success = nil
    @failure = nil
  end

  def call(value)
    start(Foo, :bar, value)
  end
end

describe 'Farah::Helpers' do
  before do
    @controller = Controller.new
  end

  describe '#start' do
    it 'calls action on runner with value' do
      value = '123'

      assert_equal @controller.start(Runners::Foo, :qux, value), value
    end
  end
end

describe 'Farah::Runner' do
  before do
    @controller = Controller.new
  end

  describe '#success!' do
    it 'sends payload with result' do
      result = @controller.call(:bar)

      assert       result.success?
      assert_equal result.payload, 'success!'
    end
  end

  describe '#failure!' do
    def @controller.bar
      failure!('failure!') unless sym == :bar
      success!('success!')
    end

    it 'sends payload with result' do
      result = @controller.call(:baz)

      assert       result.failure?
      assert_equal result.payload, 'failure!'
    end
  end
end
