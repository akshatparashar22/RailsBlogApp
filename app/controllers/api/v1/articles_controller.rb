# app/controllers/api/v1/articles_controller.rb
class Api::V1::ArticlesController < Api::V1::BaseController
  before_action :set_article, only: [:show, :update, :destroy]

  # GET /api/v1/articles
  def index
    articles = current_user.articles
    render json: articles
  end

  # POST /api/v1/articles
  def create
    result = CreateArticleService.new(article_params, current_user).call

    if result[:success]
      render json: result[:article], status: :created
    else
      render json: { errors: result[:errors] }, status: :unprocessable_entity
    end
  end

  # GET /api/v1/articles/:id
  def show
    render json: @article
  end

  # PUT /api/v1/articles/:id
  def update
    if @article.update(article_params)
      render json: @article
    else
      render json: { errors: @article.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/articles/:id
  def destroy
    @article.destroy
    head :no_content
  end

  private

  def set_article
    @article = current_user.articles.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Article not found' }, status: :not_found
  end

  def article_params
    params.require(:article).permit(:title, :content)
  end
end
