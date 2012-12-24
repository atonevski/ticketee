Given /^"(.*?)" can view the "(.*?)" project$/ do |user, project|
#   u = User.find_by_email(user)
#   u.permissions.build(:thing => Project.find_by_name!(project),
#                       :action => 'view')
  Permission.create!(:user_id => User.find_by_email!(user), 
                    'thing' => Project.find_by_name!(project),
                    :action => 'view')
end
