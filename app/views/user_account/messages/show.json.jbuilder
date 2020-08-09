json.id message.id
json.content message.content
json.created_at "Le #{l(message.created_at, format: :medium)}"
json.user_id message.user_id
json.user_name "#{message.user.first_name} #{message.user.last_name}"
