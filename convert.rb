require 'rubygems'
require 'safariwatir'
unless require 'variables' do
  puts "Please `cp variables.rb.example variables.rb` and assing correct values to the variables before proceeding"
end

browser = Watir::Safari::new
browser.goto @jira_host

puts "Press ENTER after you've logged in"
gets

@issues_to_convert.each do |issue_id|
  puts "#{@jira_host}/browse/#{issue_id}"
  browser.goto "#{@jira_host}/browse/#{issue_id}"
  
  until browser.link(:id, "issue-to-subtask").exist? do
    sleep 1
  end
  browser.link(:id, "issue-to-subtask").click
  
  until browser.text_field(:id, "parentIssueKey").exist? do
    sleep 1
  end
  browser.text_field(:id, "parentIssueKey").set @parent_issue
  browser.button(:id, 'next_submit').click
  
  until browser.text_field(:id, 'reporter').exist? do
    sleep 1
  end
  browser.text_field(:id, 'reporter').set @reporter
  browser.button(:id, 'next_submit').click
  
  until browser.button(:id, 'finish_submit').exist? do
    sleep 1
  end
  browser.button(:id, 'finish_submit').click
  
  until browser.link(:id, "editIssue").exist? do
    sleep 1
  end
end