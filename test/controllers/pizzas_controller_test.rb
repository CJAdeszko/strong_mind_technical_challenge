require "test_helper"

class PizzasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pizzas_index_url
    assert_response :success
  end

  test "should get create" do
    get pizzas_create_url
    assert_response :success
  end

  test "should get edit" do
    get pizzas_edit_url
    assert_response :success
  end
end
