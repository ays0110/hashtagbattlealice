require 'test_helper'

class BattlepointsControllerTest < ActionController::TestCase
  setup do
    @battlepoint = battlepoints(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:battlepoints)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create battlepoint" do
    assert_difference('Battlepoint.count') do
      post :create, battlepoint: { battle_id: @battlepoint.battle_id, count: @battlepoint.count, hashtag: @battlepoint.hashtag }
    end

    assert_redirected_to battlepoint_path(assigns(:battlepoint))
  end

  test "should show battlepoint" do
    get :show, id: @battlepoint
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @battlepoint
    assert_response :success
  end

  test "should update battlepoint" do
    patch :update, id: @battlepoint, battlepoint: { battle_id: @battlepoint.battle_id, count: @battlepoint.count, hashtag: @battlepoint.hashtag }
    assert_redirected_to battlepoint_path(assigns(:battlepoint))
  end

  test "should destroy battlepoint" do
    assert_difference('Battlepoint.count', -1) do
      delete :destroy, id: @battlepoint
    end

    assert_redirected_to battlepoints_path
  end
end
