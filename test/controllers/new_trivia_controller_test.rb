require 'test_helper'

class NewTriviaControllerTest < ActionController::TestCase
  setup do
    @new_trivium = new_trivia(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:new_trivia)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create new_trivium" do
    assert_difference('NewTrivium.count') do
      post :create, new_trivium: { content: @new_trivium.content, title: @new_trivium.title }
    end

    assert_redirected_to new_trivium_path(assigns(:new_trivium))
  end

  test "should show new_trivium" do
    get :show, id: @new_trivium
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @new_trivium
    assert_response :success
  end

  test "should update new_trivium" do
    patch :update, id: @new_trivium, new_trivium: { content: @new_trivium.content, title: @new_trivium.title }
    assert_redirected_to new_trivium_path(assigns(:new_trivium))
  end

  test "should destroy new_trivium" do
    assert_difference('NewTrivium.count', -1) do
      delete :destroy, id: @new_trivium
    end

    assert_redirected_to new_trivia_path
  end
end
