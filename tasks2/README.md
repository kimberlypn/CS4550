# Tasks1
## Part 1
On the home page, there is a button to register an account. As of now, the user
only needs to input a name and a unique email. The email needs to be unique
since it is used to log in, and the server will throw an error if the user tries
to register an email that is already in the database. It will also throw an
error if either field is left blank. Once the account has successfully been
created, the user is redirected to the home page, where she can then log in via
her email. The server will throw an error message if the email entered is not in
the database.
 
After logging in, the user is able to view all tasks that have been created. The
user can create a new task by clicking the 'New Task' link at the bottom left of
the table. By default, the task is assigned to the user, but she can use the
dropdown menu to choose a different user. The server will throw an error if any
of the fields are left blank. However, the 'completed' and 'time_spent' fields
have a default of false and 0, respectively. If the user wants to change the
minutes spent, it must be in increments of 15, which the server will validate
before saving to the database. After filling in all of the fields and clicking
the 'Submit' button, the user is redirected to the tasks index page, where she
can choose to edit or view any tasks. Once done, the user can log out via the
link in the top right.

## Part 2
Registration and logging in is the same as in Part 1 (see description above).
 
After loggin in, the user has access to two new links in the top left: 'Task 
Report' and 'Profile'. On the Task Report page, the user can see a table of 
tasks assigned to herself and her underlings and the status of those tasks. If 
the user has at least one underling, then she will be able to add a new task via 
the link at the bottom left. Users who are not managers are not able to create 
tasks, but they can still view tasks assigned to them. However, only managers 
can edit or delete tasks.
 
On the Profile page, the user can see her manager and underling details. The 
user can add more users to manage or unmanage current underlings by clicking the 
'Edit' link at the bottom left. When editing, the user can only see her current 
underlings and any users who do not have a manager (i.e., users who are being 
managed by someone else will not appear in this table since each user can only 
have one manager). The user can use the 'Manage'/'Unmanage' button beside each 
user to respectively manage or unmanage that user.

## How to Start Phoenix server:
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more
  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
