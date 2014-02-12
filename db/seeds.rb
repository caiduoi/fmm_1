# TODO adding the list of users
users_list= [ ['Larry Pham','larryritchie.ceo@gmail.com','Product Manager', '09/09/1989', 2, 'abcd1234!','abcd1234!'],
              ['Kelly Chan','kellychan@gmail.com','Productive Supporter','30/03/1968', 1, 'abcd1234!','abcd1234!'],
              ['Wei Ming','wei.ming@gmail.com','Software Engineer','11/02/1975', 1, 'abcd1234!','abcd1234!'],
              ['JingWei Teoh','Jingwei.teoh@gmail.com','Software Engineer','25/02/1984', 1, 'abcd1234!','abcd1234!'],
              ['Walter Teoh','walter.teoh@gmail.com','Product Manager','20/04/1957', 2, 'abcd1234!','abcd1234!'],
              ['Kelly Keong','kelly.keong@gmail.com','Software Engineer','30/03/1972', 1, 'abcd1234!','abcd1234!'],
              ['Jing Chan Toeh','jingchan.teoh@gmail.com','Product Manager','20/08/1990', 2, 'abcd1234!','abcd1234!'] ]
users_list.each do |user|
  User.create(name: user[0], email: user[1], profile: user[2], birth_date: user[3], permission: user[4], password: user[5], password_confirmation: user[6])
end

position_list = [
                  ["Member", "Member"],
                  ["Team Leader", "Team Leader"],
                  ["Project Leader", "Project Leader"]
                ]
position_list.each do |position|
  Position.create(name: position[0], abbreviation: position[1])
end
