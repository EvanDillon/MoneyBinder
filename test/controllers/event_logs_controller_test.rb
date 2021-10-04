require "test_helper"

class EventLogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event_log = event_logs(:one)
  end

  test "should get index" do
    get event_logs_url
    assert_response :success
  end

  test "should get new" do
    get new_event_log_url
    assert_response :success
  end

  test "should create event_log" do
    assert_difference('EventLog.count') do
      post event_logs_url, params: { event_log: {  } }
    end

    assert_redirected_to event_log_url(EventLog.last)
  end

  test "should show event_log" do
    get event_log_url(@event_log)
    assert_response :success
  end

  test "should get edit" do
    get edit_event_log_url(@event_log)
    assert_response :success
  end

  test "should update event_log" do
    patch event_log_url(@event_log), params: { event_log: {  } }
    assert_redirected_to event_log_url(@event_log)
  end

  test "should destroy event_log" do
    assert_difference('EventLog.count', -1) do
      delete event_log_url(@event_log)
    end

    assert_redirected_to event_logs_url
  end
end
