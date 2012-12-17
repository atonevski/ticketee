
Given /^there are the following users:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |attributes|
    unconfirmed = attributes.delete("unconfirmed") == 'true'
    is_admin    = attributes.delete('admin')
    @user = User.create!(attributes)
    @user.admin = is_admin
    # @user.update_attribute('admin', attribites['admin'] == 'true')
    @user.confirm! unless unconfirmed
  end
end


Given /^I am signed in as them$/ do
  steps <<-EOT
    Given I am on the homepage
    When I follow "Sign in"
    And I fill in "Email" with "#{@user.email}"
    And I fill in "Password" with "password"
    And I press "Sign in"
    Then I should see "Signed in successfully."
  EOT
end
