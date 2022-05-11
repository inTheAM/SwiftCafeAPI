# SwiftCafeAPI
A Server-Side Swift backend for the SwiftCafe food delivery app.
Built using Vapor and a PostgreSQL database.

<br>
<br>

## Contents:
- [Running the API](#running-the-api)
- [Contributing](#contributing)
- [Endpoints](#endpoints)
    - [Users](#users)
    - [Menu](#menu)
    
<br>
<br>

## Running the API
Install [the correct version of Docker for your Mac](https://docs.docker.com/desktop/mac/install/).
Once installed, start the docker application.
When the engine is running, in Terminal, navigate to the project folder and run:
        
        docker compose up db

This will build and run the postgres database using the default set up in the `docker-compose.yml` file: 
 - Database name: `swiftcafedb`
 - Database username: `admin`
 - Database password: `swiftcafeadmin`
 - Port: `5432`

Once the database is running, open another terminal window/tab, still in the project directory, and run:
        
        vapor run
        
This will build and run the vapor application.
You can now connect on the default address:
        
        http://localhost:8080/api
<br>
<br>

## Contributing
Take a look at the issues/project tabs for new issues or to-dos.
Here are a few ways you can improve this project:
- Adding images for each food.
- Adding/Improving documentation.
- Refactoring and breaking down large methods.
- Adding/Improving unit tests.
- Improving variable/function naming.
- Improving error handling / endpoint return types.
- Suggesting new features.
- Improving existing features.
- Improving/Extending this README.

Try to keep your PRs small and limited to specific features / bug fixes.

Make sure your code is well documented. 

This is a learning resource and should be accessible to all levels.

<br>
<br>

## ENDPOINTS:
Main path: `localhost:8080/api`

<br>

## Users:
The collection of user resources. 
- [Email availability](#email-availability-check)
- [Sign-up](#sign-up)
- [Account deletion](#account-deletion)
- [Sign-in](#sign-in)
- [Sign-out](#sign-out)
<br>

### Email availability check:   
`POST` `/users/email`

Checks whether a given email address can be used to create a new account.
Returns a boolean indicating whether the email address is available.  

Auth Requirements: `No Auth`
           

Sample request body:  

        {
            "email": "testemail@test.com"
        }
            
Sample response: `200 OK`

        {
            "result": {
                "isAvailable": true
            }
        }

<br>
    
### Sign-up:    
`POST`  `/users/`

Creates an account for a new user.
Returns a token.

Auth Requirements: `No Auth`


  
Sample request:
    
        {
            "email": "testemail@test.com",
            "password": "testpassword@123"
        }
            
Sample response: `200 OK`

        {
            "result": {
                "value": "KLV6zX+zR8id9hrnUeSsLQ=="
            }
        }
 
<br>

### Account deletion:  
`DELETE`  `/users/`
 
Deletes an existing user's account.
No return value.
        
Auth Requirements: `Bearer Token`
          

            
Sample response: `200 OK`
           
<br>
       
### Sign-in:    
`POST`  `/users/session/`

Starts a session for the user.
Returns a token.

Auth Requirements: `Basic Authorization`
          

  
Sample request:

        {
            "email": "testemail@test.com",
            "password": "testpassword@123"
        }
            
Sample response: `200 OK`
        
        {
            "result": {
                "value": "KLV6zX+zR8id9hrnUeSsLQ=="
            }
        }

<br>

### Sign-out:   
`DELETE`  `/users/session/`

Ends the current session for the user.
No return value.

Auth Requirements: `Bearer Token`
          
            
Sample response: `200 OK`

<br>
<br>

## Menu:
The collection of menu resources. 
- [Menu](#menu)
- [Options](#options)
<br>

### Menu:   
`GET` `/menu`

Returns the complete menu.
Menu format is in sections, with each section containing food items.

Auth Requirements: `Bearer Token`
            
Sample response: `200 OK`

        {
            "result": [
                        {
                            "id": "E83C6CC9-65A4-4DEA-A075-7CECE3A29FEF",
                            "details": "Slowly marinated and flame-grilled to perfection",
                            "items": [
                                {
                                    "sectionID": "E83C6CC9-65A4-4DEA-A075-7CECE3A29FEF",
                                    "id": "202F41B9-3A7A-4721-9EF7-9A1E6414735E",
                                    "details": "Plain chicken of your chosen size",
                                    "imageURL": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTP68GaMxj6iSn18pYEVZyW0lLLYgbEzbdmFQ&usqp=CAU",
                                    "name": "Chicken",
                                    "price": 3.99
                                },
                                {
                                    "sectionID": "E83C6CC9-65A4-4DEA-A075-7CECE3A29FEF",
                                    "id": "FE8C0930-F9D0-48DF-96E0-01D9C708FF59",
                                    "details": "Grilled chicken with a side of chips",
                                    "imageURL": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTP68GaMxj6iSn18pYEVZyW0lLLYgbEzbdmFQ&usqp=CAU",
                                    "name": "Chicken + Chips",
                                    "price": 5.49
                                },
                                {
                                    "sectionID": "E83C6CC9-65A4-4DEA-A075-7CECE3A29FEF",
                                    "id": "4E4E7DAE-FEE4-43BF-9C44-0A85EBE5532E",
                                    "details": "Grilled chicken with a side of rice",
                                    "imageURL": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTP68GaMxj6iSn18pYEVZyW0lLLYgbEzbdmFQ&usqp=CAU",
                                    "name": "Chicken + Rice",
                                    "price": 5.99
                                }
                            ],
                            "name": "Chicken"
                        },
                        {
                            "id": "5FCC8C0D-5AF5-4C3E-B9A1-AA79349D485F",
                            "details": "Succulent fillet flame-grilled to perfection",
                            "items": [
                                {
                                    "sectionID": "5FCC8C0D-5AF5-4C3E-B9A1-AA79349D485F",
                                    "id": "BD832CFB-142C-4C42-9B8F-27A8A101B2BF",
                                    "details": "Grilled chicken with toasted sesame bun, lettuce, tomato and caramelized onion",
                                    "imageURL": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTP68GaMxj6iSn18pYEVZyW0lLLYgbEzbdmFQ&usqp=CAU",
                                    "name": "Chicken Burger",
                                    "price": 3.49
                                },
                                {
                                    "sectionID": "5FCC8C0D-5AF5-4C3E-B9A1-AA79349D485F",
                                    "id": "C67CBDF3-6169-4910-919B-04D297AEE552",
                                    "details": "Succulent fillet flame-grilled to perfection",
                                    "imageURL": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTP68GaMxj6iSn18pYEVZyW0lLLYgbEzbdmFQ&usqp=CAU",
                                    "name": "Chicken Burger + Chips",
                                    "price": 5.49
                                }
                            ],
                            "name": "Burgers"
                        }
                      ]
        }

<br>

### Options:   
`GET` `/menu/options/{foodID}`

Returns the complete set of options for the selected food item.
Format is in groups, with each group containing options for the food.

Auth Requirements: `Bearer Token`
            
Sample response: `200 OK`

        {
            "result": [
                        {
                            "id": "0AE6E517-BCD6-4B9B-8941-F1DBDEFDB4A6",
                            "name": "Spiciness",
                            "options": [
                                {
                                    "priceDifference": 0,
                                    "id": "0A47F5A3-559B-4609-B073-47D2A5E28073",
                                    "optionGroupID": "0AE6E517-BCD6-4B9B-8941-F1DBDEFDB4A6",
                                    "name": "Plain - no spice"
                                },
                                {
                                    "priceDifference": 0,
                                    "id": "26952F21-A00E-4874-9A01-6AC5507EC103",
                                    "optionGroupID": "0AE6E517-BCD6-4B9B-8941-F1DBDEFDB4A6",
                                    "name": "Spicy - mild"
                                },
                                {
                                    "priceDifference": 0,
                                    "id": "231E1AC7-1B62-4AE7-8AA7-010C0E661B2D",
                                    "optionGroupID": "0AE6E517-BCD6-4B9B-8941-F1DBDEFDB4A6",
                                    "name": "Spicy - HOT"
                                }
                            ]
                        },
                        {
                            "id": "71EF1C0A-518C-4C05-9E6F-A5F9169548C7",
                            "name": "Chicken size",
                            "options": [
                                {
                                    "priceDifference": 0,
                                    "id": "B48E34FB-139D-4938-B05A-EF64E8036C29",
                                    "optionGroupID": "71EF1C0A-518C-4C05-9E6F-A5F9169548C7",
                                    "name": "Quarter"
                                },
                                {
                                    "priceDifference": 3,
                                    "id": "9216951A-4C7D-4F74-9FE6-D33E29DA962C",
                                    "optionGroupID": "71EF1C0A-518C-4C05-9E6F-A5F9169548C7",
                                    "name": "Half"
                                },
                                {
                                    "priceDifference": 6,
                                    "id": "C1C4FB6D-0F23-4CD5-B447-08232EBE9699",
                                    "optionGroupID": "71EF1C0A-518C-4C05-9E6F-A5F9169548C7",
                                    "name": "Full"
                                }
                            ]
                        }
                      ]
        }
