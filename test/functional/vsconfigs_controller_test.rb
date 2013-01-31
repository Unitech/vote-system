require 'test_helper'

class VsconfigsControllerTest < ActionController::TestCase
  setup do
    @vsconfig = vsconfigs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vsconfigs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vsconfig" do
    assert_difference('Vsconfig.count') do
      post :create, vsconfig: @vsconfig.attributes
    end

    assert_redirected_to vsconfig_path(assigns(:vsconfig))
  end

  test "should show vsconfig" do
    get :show, id: @vsconfig.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vsconfig.to_param
    assert_response :success
  end

  test "should update vsconfig" do
    put :update, id: @vsconfig.to_param, vsconfig: @vsconfig.attributes
    assert_redirected_to vsconfig_path(assigns(:vsconfig))
  end

  test "should destroy vsconfig" do
    assert_difference('Vsconfig.count', -1) do
      delete :destroy, id: @vsconfig.to_param
    end

    assert_redirected_to vsconfigs_path
  end
end
