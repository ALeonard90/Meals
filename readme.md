
Models and attributes:

Users:
•	name
•	email
•	password
•	phone number
Meals:
•	user_id
•	description
•	can_feed
•	pickup_time
•	pickup_location

Associations:
Users:
•	Have many meals
Meals:
•	Belong to user

Views:
1. Homepage (get)
Links to sign up, log in, Info about project

2. Sign up page (get, post)
Form containing fields for name, email, phone #, password, password confirmation
Redirect to user dashboard

3. Log in page (get, post)
Form containing fields for email, password
Redirect to user dashboard.

4. User dashboard (get)
Lists of all past meals and posts Links to post new meal Link to log out

5. Meal form (get, post)
Form containing fields for title, description
Redirect to homepage

6. Thank You Page (get)
Present animation

7. Logout page
Redirect to homepage
