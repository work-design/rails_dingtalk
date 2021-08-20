require "application_system_test_case"

class AppsTest < ApplicationSystemTestCase
  setup do
    @dingtalk_admin_app = dingtalk_admin_apps(:one)
  end

  test "visiting the index" do
    visit dingtalk_admin_apps_url
    assert_selector "h1", text: "Apps"
  end

  test "creating a App" do
    visit dingtalk_admin_apps_url
    click_on "New App"

    fill_in "Agent", with: @dingtalk_admin_app.agent_id
    fill_in "App key", with: @dingtalk_admin_app.app_key
    fill_in "App secret", with: @dingtalk_admin_app.app_secret
    fill_in "Corp", with: @dingtalk_admin_app.corp_id
    click_on "Create App"

    assert_text "App was successfully created"
    click_on "Back"
  end

  test "updating a App" do
    visit dingtalk_admin_apps_url
    click_on "Edit", match: :first

    fill_in "Agent", with: @dingtalk_admin_app.agent_id
    fill_in "App key", with: @dingtalk_admin_app.app_key
    fill_in "App secret", with: @dingtalk_admin_app.app_secret
    fill_in "Corp", with: @dingtalk_admin_app.corp_id
    click_on "Update App"

    assert_text "App was successfully updated"
    click_on "Back"
  end

  test "destroying a App" do
    visit dingtalk_admin_apps_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "App was successfully destroyed"
  end
end
