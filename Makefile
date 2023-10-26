default:
	docker compose up -d

lint:
	docker compose run --rm app sh -c flake8

or:
	@open http://github.com/guimassoqueto/python-api-tdd