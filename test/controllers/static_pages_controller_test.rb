require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get audio" do
    get :audio
    assert_response :success
  end

  test "should get lyrics" do
    get :lyrics
    assert_response :success
  end

  test "should get scores" do
    get :scores
    assert_response :success
  end

  test "should get method" do
    get :method
    assert_response :success
  end

  test "should get shows" do
    get :shows
    assert_response :success
  end

  test "should get misc" do
    get :misc
    assert_response :success
  end

end
