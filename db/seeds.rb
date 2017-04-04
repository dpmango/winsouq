AdminUser.create!([
  {email: "admin@example.com", encrypted_password: "$2a$11$9QrHmNIwiwABbDDN0VwKjuZXR2ea8uXeQ5LkbNW7ll8XLUJ.8Imo6", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2017-04-04 17:55:41", last_sign_in_at: "2017-04-04 17:55:41", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1"}
])
Category.create!([
  {name: "Food", icon: "ico-cat-food", color: ""},
  {name: "Home and Living", icon: "ico-cat-home", color: "color3"},
  {name: "Accessories", icon: "ico-cat-accesories", color: "color2"},
  {name: "Clothes", icon: "ico-cat-clothes", color: "color4"},
  {name: "Wedding and Parties", icon: "ico-cat-wedding", color: "color3"},
  {name: "Photography", icon: "ico-cat-photo", color: ""},
  {name: "Children", icon: "ico-cat-child", color: "color4"},
  {name: "Health and Beauty", icon: "ico-cat-health", color: "color2"},
  {name: "Cars", icon: "ico-cat-cars", color: "color3"}
])
