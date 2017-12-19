class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :set_post, only: [:show,:edit,:update,:destroy]


  def index
    @post = Post.new

    posts = current_user.posts.map do |post|
      post
    end

    current_user.all_following.each do |user|
      user.posts.each do |post|
        posts << post
      end
    end

    @posts = posts.sort_by &:created_at
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.json {render json: @post, status: :created}
        format.html {redirect_to posts_path, notice: 'Post was successfully created.'}
      else
        format.json {render json: @post.errors, status: :unprocessable_entity}
        format.html {redirect_to posts_path }
      end

    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.json {head :no_content}
      format.html {redirect_to posts_path, notice: 'Post was sucessfully destroyed.'}
    end
  end

  def edit
  end

  def update
  end

  def show
    @comment = Comment.new
    @comments = @post.comments
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:body).merge(user: current_user)
  end

end
