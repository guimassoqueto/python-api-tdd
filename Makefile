default:
	docker compose up -d

lint:
	docker compose run --rm app sh -c flake8

test:
	docker compose run --rm app sh -c "python manage.py test"

or:
	@open http://github.com/guimassoqueto/python-api-tdd