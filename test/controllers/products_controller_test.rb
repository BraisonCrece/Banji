require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test 'render a list of products' do
    get products_path
    assert_response :success
    assert_select '.product', 2
  end

  test 'render a detailed product' do
    get product_url(products(:PS4))
    assert_response :success
    assert_select '.title', 'PS4'
    assert_select '.description', 'En buen estado'
    assert_select '.price', '80€'  
  end

  test 'render a new product form' do
    get new_product_path
    assert_response :success
    assert_select '.formulario', 1
  end

  test 'allow to create a new product' do
    post products_path, params: {
      product: {
        title: "Nuevo producto",
        description: "descripción",
        price: 55
      }
    }
    assert_response :found
    assert_redirected_to root_path
    assert_equal flash[:notice], 'Producto agregado con éxito'
  end
  
  test 'does not allow to create a new product whit empty fields' do
    post products_path, params: {
      product: {
        title: '',
        description: "descripción",
        price: 55
      }
    }
    assert_response :unprocessable_entity
  end


  test 'allow to update a product' do
    patch product_path(products(:PS4)), params: {
      product: {
        title: "Nuevo producto",
        description: "descripción actualizada",
        price: 55
      }
    }
    assert_response :found
    assert_redirected_to root_path
    assert_equal flash[:notice], 'Producto actualizado con éxito'
  end

  test 'does not allow to update a product with an invalid field' do
    patch product_path(products(:PS4)), params: {
      product: {
        title: nil,
      }
    }
    assert_response :unprocessable_entity
  end

  test 'render an edit product form' do
    get edit_product_path(products(:Wii))
    assert_response :success
    assert_select '.formulario', 1
  end

  test 'allow to delete a product' do
    assert_difference('Product.count', -1) do
      delete product_path(products(:PS4))
    end
    assert_response :see_other
    assert_redirected_to root_path
    assert_equal flash[:alert], 'Producto eliminado con éxito'
  end
end
