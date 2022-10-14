class LibrariesController < ApplicationController
  before_action :set_library, only: %i[edit update destroy]

  def index
    @library = current_user.library
  end

  def create
    @library = current_user.build_library(library_params)
    @library.save
    redirect_to libraries_path, success: ('図書館登録しました')
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
    @library = current_user.library.find(params[:id])
    @library.destroy!
  end

  private

  def library_params
    params.require(:library).permit(:name)
  end

  def set_library
    @library = current_user.library
  end
end
