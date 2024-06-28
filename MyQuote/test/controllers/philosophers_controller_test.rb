require "test_helper"

class PhilosophersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @philosopher = philosophers(:one)
  end

  test "should get index" do
    get philosophers_url
    assert_response :success
  end

  test "should get new" do
    get new_philosopher_url
    assert_response :success
  end

  test "should create philosopher" do
    assert_difference("Philosopher.count") do
      post philosophers_url, params: { philosopher: { pbiography: @philosopher.pbiography, pdob: @philosopher.pdob, pdod: @philosopher.pdod, pfname: @philosopher.pfname, plname: @philosopher.plname } }
    end

    assert_redirected_to philosopher_url(Philosopher.last)
  end

  test "should show philosopher" do
    get philosopher_url(@philosopher)
    assert_response :success
  end

  test "should get edit" do
    get edit_philosopher_url(@philosopher)
    assert_response :success
  end

  test "should update philosopher" do
    patch philosopher_url(@philosopher), params: { philosopher: { pbiography: @philosopher.pbiography, pdob: @philosopher.pdob, pdod: @philosopher.pdod, pfname: @philosopher.pfname, plname: @philosopher.plname } }
    assert_redirected_to philosopher_url(@philosopher)
  end

  test "should destroy philosopher" do
    assert_difference("Philosopher.count", -1) do
      delete philosopher_url(@philosopher)
    end

    assert_redirected_to philosophers_url
  end
end
