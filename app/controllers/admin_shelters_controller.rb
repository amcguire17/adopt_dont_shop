class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.order_by_name
    @shelters_pending_apps = Shelter.pending_applications
  end
end
