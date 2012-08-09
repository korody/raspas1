class RelationshipsController < ApplicationController
  before_filter :authenticate

  def create
    @user = User.find(params[:relationship][:followed_id])
    relationship = current_user.follow!(@user)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
      if relationship.save
        unless relationship.followed.email.blank?
          NotificationsMailer.follower_notice(relationship).deliver
        end
      end  
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
end