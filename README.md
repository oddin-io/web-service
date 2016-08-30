# Oddin Web Service

Oddin is a platform which objective is to improve the interaction between the teacher
and the students. This is the Web Service to manage the data in the main database and
receive actions to save and print data.

## How to run

Define the environment variables described in docker-compose.yml, following the
Docker Compose requirements. You can define in a .env file on root, or set the
values in the YAML file.

After setting the environment variables, just start everything and setup the
database on Docker.

```bash
# Start the containers
docker-compose up --build

# Create and setup the database
docker-compose run server rake db:create
docker-compose run server rake db:migrate

# Populate the database with some example data
docker-compose run server rake db:seed
```
