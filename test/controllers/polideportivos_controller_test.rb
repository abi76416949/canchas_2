require "test_helper"

class PolideportivosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get polideportivos_index_url
    assert_response :success
  end

  test "should get show" do
    get polideportivos_show_url
    assert_response :success
  end

  test "should get new" do
    get polideportivos_new_url
    assert_response :success
  end

  test "should get edit" do
    get polideportivos_edit_url
    assert_response :success
  end
end
