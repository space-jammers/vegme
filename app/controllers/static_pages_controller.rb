class StaticPagesController < ApplicationController
  require "stack_exchange"
  def index
    @stack_exchange = StackExchange.new("stackoverflow", 1)
  end
end
