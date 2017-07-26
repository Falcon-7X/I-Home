class WelcomeController < ApplicationController
  def index
    flash[:notice] = "Long the bitcoin, short the world!"
  end
end
