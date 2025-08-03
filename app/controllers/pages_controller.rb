class PagesController < ApplicationController
  def dashboard
    @locations = Location.all
    @location = Location.new
  end
end
