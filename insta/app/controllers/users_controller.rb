class UsersController < ApplicationController
  before_action :set_user, only: %i[show followers follow unfollow update destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # GET /users/1/followers
  def followers
    out = @user
    followers = out.followers

    render json: followers
  end

  # POST /users/1/follow/2
  def follow
    target = User.find(params[:target_id])

    return render status: 422 if @user.followers.include? target

    @user.follow(target)

    render json: target
  end

  # POST /users/1/unfollow/2
  def unfollow
    target = User.find(params[:target_id])

    return render status: 422 unless @user.followers.include? target

    @user.unfollow(target)

    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.permit(:name, :username)
  end
end
