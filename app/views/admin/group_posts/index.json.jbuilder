json.data do
  json.items do
    json.array!(@group_posts) do |group_post|
      json.id group_post.id
      json.user do
        json.name group_post.group_member.user.name
        json.image url_for(group_post.group_member.user.profile_image)
      end
      json.gp_image url_for(group_post.gp_image)
      json.title group_post.title
      json.body group_post.body
      json.address group_post.address
      json.latitude group_post.latitude
      json.longitude group_post.longitude
    end
  end
end