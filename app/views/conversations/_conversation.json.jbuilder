json.(conversation, :id, :title)
users = conversation.users.except_user(current_user)
json.users users, :id, :name
json.is_group_chat users.count >  1
