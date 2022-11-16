class LibrariesController < ApplicationController
  before_action :set_library, only: %i[edit update destroy]

  def index
    @library = current_user.library
    if params[:address].nil?
      return
    elsif params[:address].blank?
      flash.now[:danger] = '検索キーワードが入力されていません'
      return
    elsif Geocoder.coordinates(params[:address]).nil?
      flash.now[:danger] = '無効な入力です'
      return
    else
        longitude_latitude = Geocoder.coordinates(params[:address])
        gon.longitude = longitude_latitude[1]
        gon.latitude  = longitude_latitude[0]
    end
  end

  def create
    @library = current_user.build_library(library_params)
    if @library.save
      redirect_to libraries_path, success: t('defaults.message.updated', item: Library.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: Library.model_name.human)
      redirect_to libraries_path
    end
  end

  def edit
    if params[:address].nil?
      return
    elsif params[:address].blank?
      flash.now[:danger] = '検索キーワードが入力されていません'
      return
    elsif Geocoder.coordinates(params[:address]).nil?
      flash.now[:danger] = '無効な入力です'
      return
    else
      longitude_latitude = Geocoder.coordinates(params[:address])
      gon.longitude = longitude_latitude[1]
      gon.latitude  = longitude_latitude[0]
    end
  end

  def update
    if @library.update(library_params)
      redirect_to libraries_path, success: t('defaults.message.updated', item: Library.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: Library.model_name.human)
      render :edit
    end
  end

  def destroy
    @library = current_user.library
    @library.destroy!
    redirect_to libraries_path, success: t('defaults.message.deleted', item: Library.model_name.human)
  end

  private

  def library_params
    params.require(:library).permit(:name)
  end

  def set_library
    @library = current_user.library
  end
end
