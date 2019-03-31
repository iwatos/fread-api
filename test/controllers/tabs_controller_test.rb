require 'test_helper'

class TabsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tab = tabs(:one)
  end

  test "should get index" do
    get tabs_url, as: :json
    assert_response :success
  end

  test "should create tab" do
    assert_difference('Tab.count') do
      post tabs_url, params: { tab: { name: @tab.name, user_id: @tab.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show tab" do
    get tab_url(@tab), as: :json
    assert_response :success
  end

  test "should update tab" do
    patch tab_url(@tab), params: { tab: { name: @tab.name, user_id: @tab.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy tab" do
    assert_difference('Tab.count', -1) do
      delete tab_url(@tab), as: :json
    end

    assert_response 204
  end
end
