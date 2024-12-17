.PHONY: ruby python js

up:
	docker compose up --build -d

down:
	docker compose up down

ruby:
	@echo "Running Ruby script..."
	@docker exec -it slidespeakapi-ruby_service-1 /usr/local/bin/ruby slidespeak_generator.rb

python:
	@echo "Running Python script..."
	@docker exec -it slidespeakapi-python_service-1 /usr/local/bin/python slidespeak_generator.py 

all: ruby python
	@echo "All scripts executed successfully."
