A simple API and frontend to check if it's safe to go outside. Backend API written in ruby ([grape](https://github.com/ruby-grape/grape)). Static frontend in html/jquery. 

![](screenshot.png)

## Setup 

First, sign up for an API key at AirNow.

	# clone repo
	export AIRNOW_API_KEY=YOUR_KEY_GOES_HERE
	mux
	open http://localhost:8000

List API routes

	rake routes
