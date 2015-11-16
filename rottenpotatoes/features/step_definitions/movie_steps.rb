# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  /(#{e1}).*(#{e2})/m.match(page.body).captures.size.should == 2
  #fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.gsub(' ', '').split(',').each do |rating|
    steps %Q{When I #{uncheck}check "ratings_#{rating}"}
  end
  #fail "Unimplemented"
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  #puts "Count is: " + Movie.count.to_s
  page_rows_count = page.body.scan(/<td>(PG|R|G|PG-13)<\/td>/).length
  #puts "Other count is: #{page_rows_count}"
  Movie.count.should == page_rows_count
  #fail "Unimplemented"
end
