json.(user, :id, :name)
json.is_friend current_user.is_friend?(user)
json.request_sent current_user.request_pending?(user)