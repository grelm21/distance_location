class PagesController < ApplicationController
  def dashboard
    @found_locations = []
    @locations = Location.all
    @location = Location.new
    @from, @to, @distance = nil, nil, nil
  end
end
