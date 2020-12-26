require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should prompt for login' do
    get login_url
    assert_response :success
  end

  test 'should login' do
    dave = users(:one)
    post login_url, params: { name: dave.name, password: 'secret' }
    assert_redirected_to admin_url
    assert_equal dave.id, session[:user_id]
  end

  test 'should fail login' do
    dave = users(:one)
    post login_url, params: { name: dave.name, password: 'wrong' }
    assert_redirected_to login_url
  end

  test 'should logout' do
    delete logout_url
    assert_redirected_to store_index_url
  end

  test 'should ask for login accessing users' do
    delete logout_url
    get users_url
    assert_redirected_to login_url
  end

  test 'should ask for login editing a product' do
    delete logout_url
    get users_url
    assert_redirected_to login_url
    product = products(:ruby)
    patch product_url(product), params: { product: { title: product.title, description: product.description,
                                                     image_url: product.image_url, price: product.price } }
    assert_redirected_to login_url
  end
end
