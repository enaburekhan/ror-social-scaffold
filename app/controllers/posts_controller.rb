class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    authorized_posts
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      friends_and_own_posts
      render :index, alert: 'Post was not created.'
    end
  end

  private

  def authorized_posts
    all_posts = Post.where(user: current_user.friends)
    all_posts += current_user.posts
    @authorized_posts ||= all_posts.sort { |a, b| b.created_at <=> a.created_at }
  end
 

  def post_params
    params.require(:post).permit(:content)
  end
end


