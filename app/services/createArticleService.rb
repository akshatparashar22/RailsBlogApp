# app/services/create_article_service.rb
class CreateArticleService
    def initialize(article_params, user)
      @article_params = article_params
      @user = user
    end
  
    def call
      article = @user.articles.new(@article_params)
  
      if article.save
        return { success: true, article: article }
      else
        return { success: false, errors: article.errors.full_messages }
      end
    end
  end
  