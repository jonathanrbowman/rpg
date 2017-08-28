class CharactersController < ApplicationController
  before_action :set_character, only: [:show, :edit, :update, :destroy, :verify_owner]
  before_action :verify_owner, only: [:show, :edit, :update, :destroy]

  def index
    if user_signed_in?
      @characters = current_user.characters
    else
      @users = User.all
    end
  end

  def show
  end

  def new
    @character = Character.new
  end

  def create
    @character = Character.new(character_params)

    unless current_user.blank?
      @character.user_id = current_user.id
    end

    if @character.save
      flash.notice = "#{@character.name} was created!"
      redirect_to characters_path
    else
      flash.notice = "Sorry, character could not be created!"
      render :new
    end
  end

  def edit
  end

  def update
    unless @character.blank?
      old_name = @character.name
    end

    logger.debug "debug #{@character.name} | #{params[:character][:name]}"

    if @character.name == params[:character][:name]
      flash.notice = "#{@character.name} is already the name!"
      render :edit
    else
      if @character.update_attributes(character_params)
        flash.notice = "#{old_name} was changed to #{@character.name}!"
        redirect_to characters_path
      else
        flash.notice = "Sorry, #{old_name} could not be updated!"
        render :edit
      end
    end
  end

  def destroy
    if @character.destroy
      flash.notice = "#{@character.name} was removed."
      redirect_to characters_path
    end
  end

  private

  def set_character
    if user_signed_in?
      @character = Character.find(params[:id])
    else
      flash.notice = "You need to be signed in to interact with characters."
      redirect_to characters_path
    end
  end

  def verify_owner
    if @character.user_id != current_user.id
      flash.notice = "That's not your character."
      redirect_to characters_path
    end
  end

  def character_params
    params.require(:character).permit(:name)
  end
end
