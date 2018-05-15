class ArticlesController < ApplicationController
  before_action :find_article, only: %i[show edit update destroy]
  before_action :authorize_article, only: %i[edit update destroy]

  def index
    # Article.page(params[:page]) skopiowane z kaminari
    @articles = Article.page(params[:page])

    @articles = @articles
                .where('? = any(tags)',
                       params[:q].downcase) if params[:q].present?
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(permitted_attributes(Article))
    @article.author = current_user
    if @article.save
      flash[:notice] = 'Your article has been saved.'
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def show
    @comment = @article.comments.build(commenter: session[:commenter])
    @like = Like.find_or_initialize_by(article: @article, user: current_user)
  end

  def edit; end

  def destroy
    @article.destroy
    flash[:notice] = 'Your article has been deleted.'
    redirect_to articles_path
  end

  def update
    if @article.update(permitted_attributes(@article))
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  private

  # usuwamy po stworzeniu w article_policy metody permitted_attributes
  # def article_params
  #   params.require(:article).permit(:title, :text, :tags)
  # end

  def find_article
    @article = Article.find(params[:id])
  end

  def authorize_article
    authorize @article
  end
end
