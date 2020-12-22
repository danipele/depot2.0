require 'application_system_test_case'

class LineItemsTest < ApplicationSystemTestCase
  test 'highlight line item' do
    visit store_index_url
    find('.catalog li:nth-child(1)').click_on 'Add to Cart'
    sleep 1
    find('.catalog li:nth-child(2)').click_on 'Add to Cart'
    assert_no_selector '.line-items tr:nth-child(1).line-item-highlight'
    assert_selector '.line-items tr:nth-child(2).line-item-highlight'
  end
end
