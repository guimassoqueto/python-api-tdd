# If you are running this project for the first time, make sure to follow
# the steps, from 1 to 3, the remain commands are optional

# step 1: create .env file from .env.sample
env:
	@cp .env.sample .env

# step 2: up the containers (django application and postgres)
up:
	docker compose up -d

# step 3: creates a superuser
superuser:
	docker compose run --rm app sh -c "python manage.py createsuperuser"

# optional: down all the containers running from the up command
down:
	docker compose down

# optional: if you create new models, migrations, etc, run this command to apply them in the database
datamigrations:
	docker compose run --rm app sh -c "python manage.py wait_for_db" && \
	docker compose run --rm app sh -c "python manage.py makemigrations" && \
	docker compose run --rm app sh -c "python manage.py migrate"

# Lint: command used in CI/CD pipeline in Github Actions [see .github/workflows/checks.yml line 26]
lint:
	docker compose run --rm app sh -c "flake8"

# Tests: Run Tests. Command used in CI/CD pipeline in Github Actions [see .github/workflows/checks.yml line 26]
test:
	docker compose run --rm app sh -c "python manage.py test"


# CI/CD Pipeline: used in .github/checks.yml
waitdb:
	docker compose run --rm app sh -c "python manage.py wait_for_db"

# Open github repository in the browser
or:
	@open http://github.com/guimassoqueto/python-api-tdd
