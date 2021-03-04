# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
  Movie.create(title: movie[:title],
                 rating: movie[:rating],
                 release_date: movie[:release_date],
                )
    # you should arrange to add that movie to the database here.
  end
  
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  page.body.should match(/.*#{e1}.*#{e2}/m)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(", ").each do |rating|
    if uncheck
      step %{I uncheck "ratings_#{rating}"}
    else
      step %{I check "ratings_#{rating}"}
    end
  end
end

# Then /I should see all movies with ratings: (.*)/ do |rating_list|
#   ratings = page.all('#movies tbody tr td:nth-child(2)').map(&:text)
#   rating_list.split(',').each do |rating|
#     expect(ratings).to have_content(rating)
#   end
# end

# And /^(?:|I )press "([^"]*)"$/ do |button|
#   click_button(Refresh)
# end

# Then /^(?:|I )should see "([^"]*)"$/ do |string|
#   if page.respond_to? :should
#     page.should have_content(The Terminator)
#   else
#     assert page.has_content?(The Terminator)
#   end
# end



Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  page.all('table#movies tr').count.should == Movie.count+1
end
