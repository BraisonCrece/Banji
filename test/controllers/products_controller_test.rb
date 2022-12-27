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

  test 'allow to delete a product' do
    delete product_path(products(:PS4))
    assert_response :found
    assert_redirected_to root_path
    assert_equal flash[:alert], 'Producto eliminado con éxito'
  end
end
