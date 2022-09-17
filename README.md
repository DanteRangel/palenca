# Palenca API

This is the Palenca API that serves a simple application, basically the architecture is a simple MVC

## Dependencies
In order to work with the API you need the following tools installed in your development machine:
* Ruby 3.0.0
* [Docker](https://www.docker.com/) 
We recommend to use a tool like [rbenv](https://github.com/rbenv/rbenv) or [rvm](https://rvm.io/) to change the version easily

This project uses Postgres as our DB engine, Unicorn as our web server and Nginx as reverse proxy.

## Installation
The project includes a .env.example file that contains the default values that are available with docker-compose,
you need to put that values to a .env file, you can customize this values if you want:

```
cp .env.example .env
```

Once you have all the tools you'll need to create the required volumes
, just type the following commands:

```
docker volume create --name palenca-postgres
docker volume create --name palenca-redis
```

Now you can run the containers with:

```
docker-compose up
```
Hit CTRL+C in the terminal to stop everything. If you see any errors, you can safely ignore them.


After that you'll need to create the development database 

Initialize the Database

Run the following commands to initialize the database:

```
docker-compose run palenca rake db:reset
```

```
docker-compose run palenca rake db:migrate
```

If you want to run some migrations, seeds,etc ,

(This requires the docker-compose up already running the palenca container):

Running the seeds when the container is already running
```
docker-compose exec palenca rails db:seed
```

Migrations when the container is already running

```
docker­-compose exec palenca rails db:reset
```
```
docker­-compose exec palenca rails db:migrate
```

With this you can test with `http://localhost:8000`

All our API's are under the `/` path, so you can now try something like: `http://localhost:8000/uber/login`

## Running Tests
In order to execute the tests in the project you first need to prepare the database for test environment:

```
docker-compose exec palenca rake db:test:prepare
```

With this you can now run the tests inside the Palenca Docker container:

```
docker-compose exec rails test
```

## Executing commands inside Docker container
As you probably noticed, you can run commands inside the Palenca container, you just need to use something like:

```
docker-compose exec palenca <your command goes here>
```

for example to  run the tests inside the container we can use:

```
docker-compose exec palenca rails test
```
## How resolve some issues
```
chmod -R 777 tmp/cache/
```
### Login endpoint 
The API is able to support many kind of platform in the url, example
`uber/login` , `didi/login`, `any_platform/login`

### Login endpoint 

Uber 
```
curl -X POST \
  http://127.0.0.1:8000/uber/login \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -d '{
   "email": "pierre@palenca.com",
   "password": "MyPwdChingon123"
}'
```
Code 200 - Success Response 
```
{
    "message": "SUCCESS",
    "access_token": "o65xj4z9zsO1PUiVMziTvw"
}
```
Code 401 - Unauthorized Response 
```
{
    "message": "CREDENTIALS_INVALID",
    "details": "Incorrect username or password"
}
```

For Didi
```
curl -X POST \
  http://127.0.0.1:8000/didi/login \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' 
  -d '{
   "email": "dante@palenca.com",
   "password": "MyPwdChingon123"
}
' | jq
```
Code 200 - Success Response 
```
{
    "message": "SUCCESS",
    "access_token": "OZZxEJjaghpnvL7HyGpSYQ"
}
```

### Profile endpoint

Uber 
```
curl -X GET \
  http://127.0.0.1:8000/uber/profile/o65xj4z9zsO1PUiVMziTvw \
  -H 'cache-control: no-cache'  | jq
```
```
{
    "profile": {
        "country": "mx",
        "city_name": "Ciudad de Mexico",
        "worker_id": "34dc0c89b16fd170eba320ab186d08ed",
        "first_name": "Pierre",
        "last_name": "Delarroqua",
        "email": "pierre@palenca.com",
        "phone_prefix": "+52",
        "phone_number": "5576955981",
        "rating": "4.8",
        "lifetime_trips": 1254
    },
    "platform": "uber",
    "message": "SUCCESS"
}
```
```
{
    "message": "CREDENTIALS_INVALID",
    "details": "Incorrect token"
}
```
Code 401 - Unauthorized Response 

```
{
    "message": "CREDENTIALS_INVALID",
    "details": "Incorrect username or password"
}
```

Or For Didi 

```
curl -X GET \ 
  http://127.0.0.1:8000/uber/profile/uuLDzAeFB-0-vRZ0v0XPWg \
  -H 'cache-control: no-cache' | jq
```

```
{
    "profile": {
        "country": "mx",
        "city_name": "Ciudad de Mexico",
        "worker_id": "34dc0c89b16fd170eba320ab186d08ed",
        "first_name": "Pierre",
        "last_name": "Delarroqua",
        "email": "pierre@palenca.com",
        "phone_prefix": "+52",
        "phone_number": "5576955981",
        "rating": "4.8",
        "lifetime_trips": 1254
    },
    "platform": "uber",
    "message": "SUCCESS"
}
```