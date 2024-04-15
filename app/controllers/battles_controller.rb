class BattlesController < ApplicationController
  def index
    @battles = Battle.all
    render json: { data: @battles }, status: :ok
  end
end
