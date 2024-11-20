require "test_helper"

class CanchasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get canchas_index_url
    assert_response :success
  end

  test "should get show" do
    get canchas_show_url
    assert_response :success
  end

  test "should get new" do
    get canchas_new_url
    assert_response :success
  end

  test "should get create" do
    get canchas_create_url
    assert_response :success
  end

  test "should get edit" do
    get canchas_edit_url
    assert_response :success
  end

  test "should get update" do
    get canchas_update_url
    assert_response :success
  end

  test "should get destroy" do
    get canchas_destroy_url
    assert_response :success
  end
end
