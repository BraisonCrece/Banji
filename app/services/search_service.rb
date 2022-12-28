class SearchService
  def self.search(products, params)
    if params[:min_price].present?
      products = products.where("price >= ?",params[:min_price])
    end
    if params[:max_price].present?
      products = products.where("price <= ?",params[:max_price])
    end
    if params[:category_id]
      products = products.where(category_id: params[:category_id])
    end
    if params[:query_text].present?
      products = products.search_by_keyword(params[:query_text])
    end
    sort(products, params)
  end

  def self.sort(products, params)
    order = Product::ORDER_BY.fetch(params[:order_by], Product::ORDER_BY['newest'])
    products = products.order(order)
  end
end
