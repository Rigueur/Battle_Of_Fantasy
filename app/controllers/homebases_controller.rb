class HomebasesController < ApplicationController

  def show
    @homebase = Homebase.find_by(user_id: current_user.id)

  end

end
