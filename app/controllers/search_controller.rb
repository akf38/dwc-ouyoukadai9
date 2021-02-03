class SearchController < ApplicationController
  def search
    @model = params["search"]["model"]
    @content = params["search"]["content"]
    @how = params["search"]["how"]
    @datas = search_for(@how, @model, @content)
  end
  
  private
  
  def match(model,content)
    if model == 'Users'
      User.where(name: content)
    elsif model == 'Books'
      Book.where(title: content)
    end
  end
  
  def forward(model, content)
    if model == 'Users'
      User.where("name LIKE?", "#{content}%")
    elsif model == 'Books'
      Book.where("title LIKE?", "#{content}%")
    end
  end
  
  def backward(model, content)
    if model == 'Users'
      User.where("name LIKE?", "%#{content}")
    elsif model == 'Books'
      Book.where("titile LIKE?", "%#{content}")
    end
  end
  
  def partial(model, content)
    if model == 'Users'
      User.where("name LIKE?", "%#{content}%")
    elsif model == 'Books'
      Book.where("title LIKE?", "%#{content}%")
    end
  end
  
  def search_for(how, model, content)
    case how
    when 'match'
      match(model, content)
    when 'forward'
      forward(model,content)
    when 'backward'
      backward(model, content)
    when 'partial'
      partial(model, content)
    end
  end
      
end
