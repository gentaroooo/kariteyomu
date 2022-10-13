class LibrariesController < ApplicationController
  def index; end

  def create
    @library = current_user.libraries.build(library_params)
    @library.save
    redirect_to libraries_path, success: ('図書館登録しました')
  end

  def destroy
    @library = current_user.libraries.find(params[:id])
    @library.destroy!
  end

  private

  def library_params
    params.require(:library).permit(:name)
  end
end
