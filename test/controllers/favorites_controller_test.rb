require "test_helper"

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login
    @megadrive = products(:megadrive)
    @wii = products(:Wii)
  end

  test "should create favorite" do
    assert_difference('Favorite.count', +1) do
      post favorites_url(product_id: @megadrive.id)
    end
    assert_response :found
    assert_redirected_to product_url(@megadrive)
  end

  test "should delete favorite" do
    assert_difference("Favorite.count", -1) do
      delete favorite_url(@wii.id)
    end
    assert_response :see_other
    assert_redirected_to product_url(@wii)
  end
end
