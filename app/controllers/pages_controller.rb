class PagesController < ApplicationController
  def dashboard
    @locations = Location.all
    @location = Location.new
    @from, @to, @distance = nil, nil, nil
  end
end
