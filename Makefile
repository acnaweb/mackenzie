iac:
	docker build -t devops .
	docker run --name devops -it --rm -v ./shared:/shared devops /bin/bash


