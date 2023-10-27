up:
	docker compose up -d

down:
	docker compose down

# creates a superuser
superuser:
	docker compose run --rm app sh -c "python manage.py createsuperuser"

# command used in CI/CD pipeline in Github Actions [see .github/workflows/checks.yml line 23]
waitdb:
	docker compose run --rm app sh -c "python manage.py wait_for_db"

# migrations
migrations:
	docker compose run --rm app sh -c "python manage.py makemigrations"

migrate:
	docker compose run --rm app sh -c "python manage.py migrate"

# Lint: command used in CI/CD pipeline in Github Actions [see .github/workflows/checks.yml line 26]
lint:
	docker compose run --rm app sh -c "flake8"

# Tests: Run Tests. Command used in CI/CD pipeline in Github Actions [see .github/workflows/checks.yml line 26]
test:
	docker compose run --rm app sh -c "python manage.py test"

# Create .env file from .env.sample
env:
	@cp .env.sample .env

# Open github repository in the browser
or:
	@open http://github.com/guimassoqueto/python-api-tdd
