class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def show
    @comment = @article.comments.build(commenter: session[:commenter])
  end

  def edit
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  def update
    if @article.update(article_params)
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def sanitize_tags(text)
    text.downcase.split.uniq
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end

  def find_article
    @article = Article.find(params[:id])
  end
end
