require 'test_helper'

class MeDemosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @me_demo = me_demos(:one)
  end

  test "should get index" do
    get me_demos_url
    assert_response :success
  end

  test "should get new" do
    get new_me_demo_url
    assert_response :success
  end

  test "should create me_demo" do
    assert_difference('MeDemo.count') do
      post me_demos_url, params: { me_demo: { me_text: @me_demo.me_text } }
    end

    assert_redirected_to me_demo_url(MeDemo.last)
  end

  test "should show me_demo" do
    get me_demo_url(@me_demo)
    assert_response :success
  end

  test "should get edit" do
    get edit_me_demo_url(@me_demo)
    assert_response :success
  end

  test "should update me_demo" do
    patch me_demo_url(@me_demo), params: { me_demo: { me_text: @me_demo.me_text } }
    assert_redirected_to me_demo_url(@me_demo)
  end

  test "should destroy me_demo" do
    assert_difference('MeDemo.count', -1) do
      delete me_demo_url(@me_demo)
    end

    assert_redirected_to me_demos_url
  end
end
