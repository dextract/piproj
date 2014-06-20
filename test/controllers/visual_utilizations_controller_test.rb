require 'test_helper'

class VisualUtilizationsControllerTest < ActionController::TestCase
  setup do
    @visual_utilization = visual_utilizations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:visual_utilizations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create visual_utilization" do
    assert_difference('VisualUtilization.count') do
      post :create, visual_utilization: { content_id: @visual_utilization.content_id, visual_id: @visual_utilization.visual_id }
    end

    assert_redirected_to visual_utilization_path(assigns(:visual_utilization))
  end

  test "should show visual_utilization" do
    get :show, id: @visual_utilization
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @visual_utilization
    assert_response :success
  end

  test "should update visual_utilization" do
    patch :update, id: @visual_utilization, visual_utilization: { content_id: @visual_utilization.content_id, visual_id: @visual_utilization.visual_id }
    assert_redirected_to visual_utilization_path(assigns(:visual_utilization))
  end

  test "should destroy visual_utilization" do
    assert_difference('VisualUtilization.count', -1) do
      delete :destroy, id: @visual_utilization
    end

    assert_redirected_to visual_utilizations_path
  end
end
