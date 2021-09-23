require 'test_helper'
class Dingtalk::Admin::AppsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @app = apps(:one)
  end

  test 'index ok' do
    get url_for(controller: 'dingtalk/admin/apps')

    assert_response :success
  end

  test 'new ok' do
    get url_for(controller: 'dingtalk/admin/apps')

    assert_response :success
  end

  test 'create ok' do
    assert_difference('Dingtalk::App.count') do
      post(
        url_for(controller: 'dingtalk/admin/apps', action: 'create'),
        params: { app: { agent_id: @app.agent_id, app_key: @app.app_key, app_secret: @app.app_secret, corp_id: @app.corp_id } },
        as: :turbo_stream
      )
    end

    assert_response :success
  end

  test 'show ok' do
    get url_for(controller: 'dingtalk/admin/apps', action: 'show', id: @app.id)

    assert_response :success
  end

  test 'edit ok' do
    get url_for(controller: 'dingtalk/admin/apps', action: 'edit', id: @app.id)

    assert_response :success
  end

  test 'update ok' do
    patch(
      url_for(controller: 'dingtalk/admin/apps', action: 'update', id: @app.id),
      params: { app: { agent_id: @app.agent_id, app_key: @app.app_key, app_secret: @app.app_secret, corp_id: @app.corp_id } },
      as: :turbo_stream
    )

    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Dingtalk::App.count', -1) do
      delete url_for(controller: 'dingtalk/admin/apps', action: 'destroy', id: @app.id), as: :turbo_stream
    end

    assert_response :success
  end

end
