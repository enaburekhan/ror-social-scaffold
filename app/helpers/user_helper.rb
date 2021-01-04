module UserHelper
  def render_friendship_btn(user)
    return if current_user == user

    friendship_param = { friendship: { user_id: current_user, friend_id: user, confirmed: false } }
    delete_param = { id: user.id }

    if !current_user.friend?(user) && !current_user.already_friend?(user)
      link_to 'Add Friend', friendships_path(friendship_param),
              method: :post, class: 'green'

    elsif !current_user.already_friend?(user)
      link_to 'Remove friend',
              friendship_path(delete_param),
              method: :delete, class: 'red'

    elsif current_user.already_friend?(user)
      link =capture {link_to 'Delete Request', friendship_path(delete_param),
        method: :delete, class: 'red'}
      link<< capture {link_to 'Pengind request..', friendship_path(current_user),
        class: 'yellow2'}
        
      end
    end
  end

  def render_request_btn(user)


  end
