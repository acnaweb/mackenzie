export PROJECT_DIR=data_pipeline_postgres
export PROFILE_DIR=$(shell pwd)/profiles

# Local development
install:
	python -m venv venv; \
	. venv/bin/activate; \
	pip install --upgrade pip; \
	pip install -e .[interactive]; \

test:
	pytest

create_dbt:
	dbt init --profiles-dir $(PROFILE_DIR)

debug:
	dbt debug --profiles-dir $(PROFILE_DIR) --project-dir $(PROJECT_DIR)

run: 	
	dbt run --profiles-dir $(PROFILE_DIR) --project-dir $(PROJECT_DIR)

run_debug: 	
	dbt run --profiles-dir $(PROFILE_DIR) --project-dir $(PROJECT_DIR) --debug

compile: 	
	dbt compile --profiles-dir $(PROFILE_DIR) --project-dir $(PROJECT_DIR)

seed: 	
	dbt seed --profiles-dir $(PROFILE_DIR) --project-dir $(PROJECT_DIR)

docs: 	
	dbt docs generate --profiles-dir $(PROFILE_DIR) --project-dir $(PROJECT_DIR)
	dbt docs serve --profiles-dir $(PROFILE_DIR) --project-dir $(PROJECT_DIR) --port 8081
