# frozen_string_literal: true
class MonstersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  before_action :set_monster, only: [:show, :edit, :update, :destroy]

  def index
    @monsters = Monster.all
    render json: { data: @monsters }, status: :ok
  end

  def show
    render json: { data: @monster }, status: :ok
  end

  def new
    @monster = Monster.new
  end

  def create
    @monster = Monster.new(monster_params)

    if @monster.save
      render json: { data: @monster }, status: :created
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @monster.update(monster_params)
      render json: { data: @monster }, status: :ok
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @monster.destroy
      redirect_to root_path, status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def import
    file = params[:file]

    if file
      import_service = CsvImportService.new(file).call

      if import_service.success?
        render json: { message: import_service.payload[:message] }, status: :created
      else
        render json: { message: import_service.error }, status: :bad_request
      end
    else
      render json: { message: 'Please, provide a file.' }, status: :bad_request
    end
  end

  private

  def set_monster
    @monster = Monster.find(params[:id])
  end

  def monster_params
    params.require(:monster)
          .permit(:name, :image_url, :attack, :defense, :hp, :speed)
  end

  def not_found
    render json: { message: 'The monster does not exists.' }, status: :not_found
  end
end
