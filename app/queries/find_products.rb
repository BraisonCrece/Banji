class FindProducts
  attr_reader :products

  def initialize(products = initial_scope)
    # if an FindProducts object is initialized without a products argument, it will use the initial_scope method.
    @products = products
  end

  def call(params = {})
    # if the method is called without parameters, it will use an empty hash as default.
    scoped = @products
    scoped = filter_by_category_id(scoped, params[:category_id])
    scoped = filter_by_min_price(scoped, params[:min_price])
    scoped = filter_by_max_price(scoped, params[:max_price])
    scoped = filter_by_query(scoped, params[:query_text])
    scoped = filter_by_user_id(scoped, params[:user_id])
    scoped = filter_by_favorites(scoped, params[:favorite])
    scoped = sort(scoped, params[:order_by])
  end

  private

  def initial_scope
    # Returns all the products with their images attached.
    Product.with_attached_images
  end

  # queries
  def filter_by_category_id(scoped, category_id)
    return scoped unless category_id.present?
    scoped.where(category_id: category_id)
  end

  def filter_by_min_price(scoped, min_price)
    return scoped unless min_price.present?
    scoped.where("price >= ?", min_price)
  end

  def filter_by_max_price(scoped, max_price)
    return scoped unless max_price.present?
    scoped.where("price <= ?", max_price)
  end

  def filter_by_query(scoped, query_text)
    return scoped unless query_text.present?
    scoped.search_by_keyword(query_text)
  end

  def filter_by_user_id(scoped, user_id)
    return scoped unless user_id.present?
    scoped.where(user_id: user_id)
  end

  def filter_by_favorites(scoped, favorite)
    return scoped unless favorite.present?

    scoped.joins(:favorites).where({ favorites: { user_id: Current.user.id } })
  end

  def sort(scoped, order_by)
    order = Product::ORDER_BY.fetch(order_by, Product::ORDER_BY["newest"])
    scoped.order(order)
  end
end
