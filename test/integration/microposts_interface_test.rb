require "test_helper"

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
<<<<<<< HEAD
<<<<<<< HEAD
    @user = users(:beket)
  end

  test "micropost interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    assert_select 'input[type=file]'

    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { content: "" } }
    end
    assert_select 'div#error_explanation'

    content = "This micropost really ties the room together"
    picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    assert_difference 'Micropost.count', 1 do
      post microposts_path, params: { micropost: { content: content, picture: picture } }
    end
    assert assigns(:micropost).picture?

    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body

=======
=======
>>>>>>> 5fc102a9aaa073da05411e7e175123361bf596ee
    @user = users(:michael)
  end

  test "micropost interface" do
    log_in_as(@user) get root_path
    assert_select 'div.pagination'
    # Недопустимая информация в форме.
    assert_no_difference 'Micropost.count' do
      post microposts_path, micropost: { content: "" }
    end
    assert_select 'div#error_explanation'
    # Допустимая информация в форме.
    content = "This micropost really ties the room together"
    assert_difference 'Micropost.count', 1 do
      post microposts_path, micropost: { content: content }
    end
    assert_redirected_to root_url follow_redirect!
    assert_match content, response.body
    # Удаление сообщения.
<<<<<<< HEAD
>>>>>>> 5fc102a9aaa073da05411e7e175123361bf596ee
=======
>>>>>>> 5fc102a9aaa073da05411e7e175123361bf596ee
    assert_select 'a', text: 'delete'
    first_micropost = @user.microposts.paginate(page: 1).first
    assert_difference 'Micropost.count', -1 do
      delete micropost_path(first_micropost)
    end
<<<<<<< HEAD
<<<<<<< HEAD

    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end

  test "micropost sidebar count" do
    log_in_as(@user)
    get root_path
    assert_match "#{34} microposts", response.body

    other_user = users(:malory)
    log_in_as(other_user)
    get root_path
    assert_match "0 microposts", response.body
    other_user.microposts.create!(content: "A micropost")
    get root_path
    assert_match /A micropost/, response.body
  end
=======
=======
>>>>>>> 5fc102a9aaa073da05411e7e175123361bf596ee
    # Переход в профиль другого пользователя.
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end
<<<<<<< HEAD
>>>>>>> 5fc102a9aaa073da05411e7e175123361bf596ee
=======
>>>>>>> 5fc102a9aaa073da05411e7e175123361bf596ee
end
