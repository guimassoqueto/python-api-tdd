up:
	docker compose up -d

down:
	docker compose down

lint:
	docker compose run --rm app sh -c "flake8"

test:
	docker compose run --rm app sh -c "python manage.py test"

env:
	@cp .env.sample .env

or:
	@open http://github.com/guimassoqueto/python-api-tdd
