#clicks on 'control'
def ClickOnControl(control)
 control.wait_until_present
 control.click
end
#sets 'text' to 'control'
def SetText(control, text)
 control.wait_until_present
 control.set text
end
#checks that control contains 'text'
def DoesContainText(control, text)
 control.wait_until_present
 puts 'Current lead status:'
 puts innertext = control.text
 puts 'Does current status correct:'
 result1 = innertext.eql? text  
end
#constant strings
link              = 'https://getbase.com/pricing/'
email             = 'natali.zelskaya@gmail.com'
password          = 'q1w2e3'
leadsLastName     = 'Zelska Test'
leadStatus        = 'New'
leadStatusChanged = 'Test'
#end

#running FireFox browser
require "watir-webdriver"
b = Watir::Browser.new :ff
#maximize browser window
b.window.maximize

#controls declaration 
loginMenu            = b.header(:id => 'page-header').link(:text => 'Login')
newUserForm          = b.form(:id => 'user_new')
emailField           = newUserForm.text_field(:id => 'user_email')
passwordField        = newUserForm.text_field(:id => 'user_password')
loginBtn             = newUserForm.button(:class => 'btn-primary')
leadsTab             = b.ul(:id => 'nav-main').link(:id => 'nav-leads')
skipBtn              = b.div(:id => 'reports-loader-skip-intro').link(:class => 'gray')
addLeadsBtn          = b.span(:id => 'selection').link(:text => 'Lead')
leadsLastNameField   = b.div(:class => 'lead-fields').text_field(:id => 'lead-last-name')
saveBtn              = b.div(:class => 'edit-buttons').button(:text => 'Save')
leadStatusField      = b.div(:class => 'status').span(:class => 'lead-status')
settingsIcon         = b.li(:id => 'user-dd').i(:class => 'icon-cogs')
settingTab           = b.ul(:class => 'topbar-settings-dropdown').link(:href => '/settings/profile')
leadSubTab           = b.div(:id => 'sidebar').link(:href => '/settings/leads')
leadStatusesTab      = b.div(:class => 'settings-content').link(:text => 'Lead Statuses')
leadStatuses         = b.div(:id => 'lead-status')
editIcon             = leadStatuses.h4(:text => leadStatus)
editStatusField      = leadStatuses.text_field(:text => leadStatus)
createdLeadsList     = b.div(:class => 'leads').ul(:class => 'object-list-items leads')
#end

#open Base site
b.goto link
#click on LOGIN tab
puts ClickOnControl(loginMenu)
#set Email field
puts SetText(emailField, email)
#set Password field
puts SetText(passwordField, password)
#click on Log in button
puts ClickOnControl(loginBtn)
#click on Leads menu
puts ClickOnControl(leadsTab)
#click on skip button in 'Introducing Lead and Deal Scoring' window
puts ClickOnControl(skipBtn)
#click on add leads button
puts ClickOnControl(addLeadsBtn)
#set Last Name for lead
puts SetText(leadsLastNameField, leadsLastName)
#press Save button
puts ClickOnControl(saveBtn)
#check that newly created lead has status New
puts leadStatusNewExists = DoesContainText(leadStatusField, leadStatus)
#if status isn't New than stop test
if !leadStatusNewExists
 puts 'Please, change Lead Status to New'
else
 #click on Settings icon 
 puts ClickOnControl(settingsIcon)
 #click on Settings tab
 puts ClickOnControl(settingTab)
 #click on Leads tab in Settings
 puts ClickOnControl(leadSubTab) 
 #click on Lead Statuses tab
 puts ClickOnControl(leadStatusesTab)
 #click on Edit button for New status
 editStatusIcon = editIcon.parent.parent.button(:class => 'edit')
 puts ClickOnControl(editStatusIcon)
 #set lead status Name to New Test
 puts SetText(editStatusField, leadStatusChanged)
 #save lead status new name
 saveStatusBtn = editStatusField.parent.parent.parent.button(:text => 'Save')
 puts ClickOnControl(saveStatusBtn)
 #go to Leads menu
 puts ClickOnControl(leadsTab)
 #open first lead
 puts ClickOnControl(createdLeadsList.li(:index => 1).link(:class => 'lead-name'))
 #check that lead status changed to Test
 puts DoesContainText(leadStatusField,leadStatusChanged)
end
#close browser
b.close
