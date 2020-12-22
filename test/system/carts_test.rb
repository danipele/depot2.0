require 'application_system_test_case'

class CartsTest < ApplicationSystemTestCase
  test 'show and hide cart' do
    visit store_index_url
    assert_no_selector '.cart'
    first('.catalog li').click_on 'Add to Cart'
    assert_selector '.cart'
    click_on 'Empty cart'
    page.driver.browser.switch_to.alert.accept
    assert_no_selector '.cart'
  end
end
