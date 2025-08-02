class PagesController < ApplicationController
  def dashboard
    @found_locations = []
    @locations = Location.all
    @location = Location.new
  end
end
