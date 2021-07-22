class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pet_application = PetApplication.all

    if @pet_application.pet_rejected_on_complete_application?(@application.id)
      @application.update(status: 'Rejected')
    elsif @pet_application.all_pets_on_application_reviewed?(@application.id)
      @application.update(status: 'Approved')
      @application.pets.update_all(adoptable: false)
    end
  end
end
