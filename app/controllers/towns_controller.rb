class TownsController < ApplicationController

  def show
    @town = Town.find_by(user_id: current_user.id)

  end

end
