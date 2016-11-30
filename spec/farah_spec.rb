require_relative './spec_helper'

module Runners
  include Farah::Helpers

  class Foo < Farah::Runner
    def bar(sym)
      success('success') if sym == :bar
      failure('failure')
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
    run(Foo, :bar, value)
  end

  def on_bar_success(payload)
    @success = payload
  end

  def on_bar_failure(payload)
    @failure = payload
  end
end

describe 'Farah::Helpers' do
  before do
    @controller = Controller.new
  end

  describe '#run' do
    it 'calls action on runner with value' do
      value = '123'

      assert_equal @controller.run(Runners::Foo, :qux, value), value
    end
  end
end

describe 'Farah::Runner' do
  before do
    @controller = Controller.new
  end

  describe '#success' do
    it 'sends payload to callback' do
      @controller.call(:bar)

      assert_equal @controller.success, 'success'
    end

    it 'returns early' do
      @controller.call(:bar)

      assert_equal @controller.success, 'success'
      assert_nil   @controller.failure
    end
  end

  describe '#failure' do
    def @controller.bar
      failure!('failure') unless sym == :bar
      success!('success')
    end

    it 'sends payload to callback' do
      @controller.call(:bat)

      assert_equal @controller.failure, 'failure'
    end

    it 'returns early' do
      @controller.call(:baz)

      assert_nil   @controller.success
      assert_equal @controller.failure, 'failure'
    end
  end
end
