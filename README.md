#### App code base details:

Fuber call taxi service, customers provide their current location to find the cab and book the ride.
All data is stored in memory. Whenever we start the server(rails s) config/initializers/prepare_data.rb file got automatically executed and load cab details.

1. app/controller has all API request and response related codebase
2. app/service has business logic codebase for appropriate APIs
3. app/model has data models for application.
4. spec/services and spec/controllers has the unit test cases codebase.
config/locales/en.yml has all validations, success and error message

### APIs Details:
      
#### 1. Search Cabs API:
    Search cabs API will provide the available nearest cab


    URL: http://localhost:3000/search_cabs?latitude=9&longitude=9&color=blue

    HTTP Method: Get
    Headers: Content-Type: application/json
    Request:
        latitude: should be a float or integer type
        longitude: should be a float or integer type
        color: should be a string type
    Response:
    	{ "cab_details": {
    	  "id": 3,
    	  "status": 5,
    	  "color": "blue",
    	  "geo_location": {
    	      "latitude": 20,
    	      "longitude": 3
    	  },
    	  "vehicle_num": "KA 10 2030"}}

#### 2. Book Ride API.
This API will confirm your ride and assign cab to customer. create a new ride in memory, API required vehicle_num, customer name, mobile number, source and destination, vehicle_num will get from the previous API. response will get ride_id,


	 URL: http://localhost:3000/book_ride

	 HTTP Method: Post

	 Headers: Content-Type: application/json

	 Request: 
			{
			  "vehicle_num": "KA 10 2020",
			  "name": "arun",
			  "mobile_number": 8989898989,
			  "source": {
			    "latitude": 19,
			    "longitude": 8
			  },
			  "destination": {
			    "latitude": 88,
			    "longitude": 8
			  }
			}

      Response:
         { "cab_number": "KA 10 2020",
            "ride_id": 1,
            "message": "Successfully Booked your Ride"}

#### 3. Start Ride API.
   Start ride api will start the ride. update ride and cab status as in progress. need to send request as a ride_id, ride_id will get from previous API


    URL: http://localhost:3000/start_ride
    
    HTTP Method: Post
    
    Headers: Content-Type: application/json
    
    Request: {"id": 1 }
    
    Response:
        { "message": "Your Ride in progress" }


#### 4. End Ride API, this API will complete the ride.
Need to send a request as a ride_id, response will get pricing details. after that will update the cab location details and status. cab will available for other customer. also update the ride status and total_amt


        URL: http://localhost:3000/start_ride

        HTTP Method: Post
        
        Headers: Content-Type: application/json
        
        Request: {"id": 1 }
        
        Response:
        {
        	  "message": "Your Ride completed",
        	  "pricing": {
        	    "total_amt": 144,
        	    "total_min": 6,
        	    "total_km": 69
        	  }
        }

	

### Tech stack:
    Language: Ruby 2.5.1.
 	Framework: Rails 5.2.4
 	UnitTest: Rspec 3.8

### App setup and start the server
  
   
    1. Clone the code form github
  	2. Install RVM from https://rvm.io/rvm/install
  	3. Install Ruby version 2.5.1
      		$ rvm install ruby-2.5.1
  	4. Install Rails Framework
      		$ gem install rails -v 5.2.4
    5. Do install app dependency gems
        	$ bundle install
  	6. Start the server, by default server listen to the port 3000
      		$  rails s

### Running Unit Test cases
    1 Go to app root folder
    2 Run the rspec cmd to execute all test cases
    3 rspec
