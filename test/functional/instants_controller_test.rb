require 'test_helper'

class InstantsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:instants)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create instant" do
    assert_difference('Instant.count') do
      post :create, :instant => { }
    end

    assert_redirected_to instant_path(assigns(:instant))
  end

  test "should show instant" do
    get :show, :id => instants(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => instants(:one).to_param
    assert_response :success
  end

  test "should update instant" do
    put :update, :id => instants(:one).to_param, :instant => { }
    assert_redirected_to instant_path(assigns(:instant))
  end

  test "should destroy instant" do
    assert_difference('Instant.count', -1) do
      delete :destroy, :id => instants(:one).to_param
    end

    assert_redirected_to instants_path
  end
end
