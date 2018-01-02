json.user do
  json.current_user current_user.as_json
end

json.conversations do
  json.array! @conversations, partial: 'conversation', as: :conversation
end