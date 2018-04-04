# Task Tracker

## Part 3

On the home page, users will see a message asking them to log in. If they do 
not have an account yet, they can toggle the registration form by clicking the 
"here" link. To register an account, users need to input a unique email address 
(case insensitive), their name, and a password that is at least eight 
characters long. The email needs to be unique since it is used to log in. The 
server will throw an error if any of the fields are left blank, if users try to 
register an email that is already in the database, or if the password is too 
short. Errors are displayed as an alert message. 

Once users have an account, they can log in via the log-in form in the 
top-right. After users click the "Log In" button, the server hashes the entered 
password and checks the email and password hash combination against the 
database. If the authentication succeeds, a token is created, and users will be 
able to see their dashboards. 

The dashboard is divided into two sections: tasks assigned to the user and 
tasks created by the user but assigned to others. Any other tasks in the 
database are not visible to the user. The tasks are ordered by create date in 
descending order, so the newest created task is in the top-left. In the 
top-right of each task card are an "Edit" button and a "Delete" button. 
Clicking the "Edit" button toggles the edit task form. If users successfully 
fill out the form, they will see the details in the corresponding task card get 
updated upon clicking "Submit". There is also a "Cancel" button to close the 
form if users change their mind. The "Delete" button allows users to delete 
individual tasks. 

Beside the "Dashboard" link in the navigation bar is a "New Task" link. Here, 
users can create new tasks via a form similar to the edit task form. The server 
will throw an error if any of the fields are blank. The "Completed" and 
"Minutes Spent" fields have a default of false and 0, respectively. If users want 
to change the minutes spent, it must be in increments of 15, which the server 
will validate before saving to the database. Furthermore, the title of the task 
is limited to 75 characters. If users successfully fill out the form, they will 
receive an alert indicating so and can view the newly created task by going 
back to the dashboard.

Once done, users can log out via the "Log Out" link in the top-right. Clicking 
this link resets the state, which includes the token. 

## Workflow
When users first visit the homepage, they will see a message telling them to 
log in.
![homepage](screenshots/homepage.png) 

If users do not have an account, they can use the "here" link to create 
one. This link will toggle the registration form. 
![registration form](screenshots/registration-form.png) 

After logging in, users will see their dashboard. The dashboard is organized by 
tasks assigned to the user and tasks created by the user but assigned to 
others. 
![dashboard](screenshots/dashboard.png) 

Users can edit the details of an individual task by clicking the "Edit" button 
in the top-right of the task card. This button will toggle the edit form. 
Beside the "Edit" button is a "Delete" button, which users can use to delete an 
individual task. 
![editing a task](screenshots/edit-task.png) 

Users can create a new task by clicking the "New Task" link in the navigation 
bar. This link will redirect them to a new task form. 
![creating a new task](screenshots/new-task.png) 

Users can log out by clicking the "Log Out" link in the top-right. After 
logging out, users will be redirected back to the homepage.
