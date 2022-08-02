class WelcomeController < ApplicationController
  def index
    @pizzas = Pizza.all
  end
end
