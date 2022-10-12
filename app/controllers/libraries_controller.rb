class LibrariesController < ApplicationController
  def index; end

  def create
    binding.pry
    @library = current_user.libraries.build(library_params)
    @library.save
    # @name = library_params
    binding.pry
    redirect_to libraries_path, success: t('.success')
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
