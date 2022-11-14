class LibrariesController < ApplicationController
  before_action :set_library, only: %i[edit update destroy]

  def index
    @library = current_user.library

    if params[:location].nil?
      return
    elsif params[:location].blank?
      flash.now[:danger] = '検索キーワードが入力されていません'
      return
    else
      @location = params[:location]
      gon.location = @location
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

  def edit; end

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
