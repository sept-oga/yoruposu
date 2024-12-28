json.data do
  json.items do
    json.array!(@group_posts) do |group_post|
      json.id group_post.id
      json.user do
        json.name group_post.user.name
        json.image url_for(group_post.user.profile_image)
      end
      json.image url_for(group_post.gp_image)
      json.shop_name group_post.title
      json.caption group_post.body
      json.address group_post.address
      json.latitude group_post.latitude
      json.longitude group_post.longitude
    end
  end
end