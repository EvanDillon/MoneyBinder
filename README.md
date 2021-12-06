# MoneyBinder

MoneyBinder is an accounting software developed for a class called Application Domain at Kennesaw State University. In this class we learned about a domain (accounting) and then applied what we learned by creating a fully functioning web application from the ground up.
* Check out [MoneyBinder on Heroku](https://moneybinder.herokuapp.com/)
* Video demo of [MoneyBinder](https://youtu.be/MROQGBXpNeU)

## How to login

**Admin User**
* Username: Admin
* Password: password

**Manager User**
* Username: Manager
* Password: password

**Accountant User**
* Username: Accountant
* Password: password

## Features

* User authorization
* Ability to reset password using an email token
* Dashboard with live ratios based on the data 
* Ability to create and edit the Chart of Accounts (admin only)
* Fully functioning ledger for each Account with post references
* Event log that records all changes to Accounts, Users, and Journal Entries
* Journalize transactions (manager/accountant only)
* Attach multiple files when creating new journal entries
* Ability to add multiple debits/credits when creating a new journal entry
* Approve/decline entries (manager only)
* Create closing entry for the new accounting period (manager only)
* Generates reports including trial balance, income statements, retained earnings, and balance sheet
* Ability to email, save, and print PDF of any report
* Tooltips for every clickable feature


## What we used
* **Language** - Ruby
* **Framework** - Ruby on Rails
* **Database** - Postgresql
* **Cloud Platform** - Heroku
* **Version Control** - GitHub 
* **Gems** - See "GemFile"

## Authors
* [Evan Dillon](www.linkedin.com/in/evanjdillon)
* Katie H
* [James Diaz](www.linkedin.com/in/diazjames)
* Andrew Shein
* Jonathan Perry
