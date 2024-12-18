.PHONY: ruby python js

up:
	docker compose up --build -d

down:
	docker compose down

ruby:
	@echo "Running Ruby script..."
	@docker exec -it ruby_service /usr/local/bin/ruby slidespeak_generator.rb

python:
	@echo "Running Python edit script..."
	@docker exec -it python_service /usr/local/bin/python slidespeak_editor.py 

python_simple:
	@echo "Running Python script..."
	@docker exec -it python_service /usr/local/bin/python slidespeak_generator.py 

all: ruby python python_simple
	@echo "All scripts executed successfully."
