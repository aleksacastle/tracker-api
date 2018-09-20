## Issue tracker REST API
 
### Stack:
 
__Framework__: Rails 5

__Test__: Rspec

__Authorization and authentication__: JWT



### How to login
#### by Postman
1) if not registered before
    
    
    visit '/signup'

choose *POST* request,

in Headers choose
    
    Content-type: application/x-www-form-urlencoded

in Body enter next key-value pairs:


    name: <Your name>
    email: <Your email>
    password: <Your password>


click Send

Remember auth_token that will return in case of success

 2) if already registered
 
    
    visit '/auth/login'
    
 choose *POST* request,
 
 in Body enter next key-value pairs:
 
     email: <Your email>
     password: <Your password>
 
 
 click Send
 
 Remember auth_token that will return in case of success
    
#### with cURL

1) Register

        curl -X POST "http://localhost:3000/signup" 
        -d '{"name": "<Your name>", "email": "<Your email>", "password": "<Your password>"}' 
        -H "Content-Type: application/x-www-form-urlencoded"
    
2) Login
       
        curl -X POST "http://localhost:3000/auth/login" 
        -d '{"email": "<Your email>", "password": "<Your password>"}' 
        -H "Content-Type: application/json"

### How to authorize Api request
#### by Postman
In Headers 

    Content-type: application/json
    Authorization: <auth_token obtained on Register/Login stage>
    
#### by cURL

Add to request auth_token
    
    "Authorization: JWT <auth_token obtained on Register/Login stage>"