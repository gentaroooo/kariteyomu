class RelationshipsController < ApplicationController
  def create
    @other_user = User.find(params[:follower])
    current_user.follow(@other_user)
  end

  def destroy
    @other_user = current_user.active_relationships.find(params[:id]).follower
    current_user.unfollow(@other_user)
  end
end
