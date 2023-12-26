up:
	docker image prune -f --filter "label=com.docker.compose.project=background-process-worker"
	docker compose up -d --force-recreate --build background-process-worker

down:
	docker compose down

stop:
	docker compose stop

logs:
	docker compose logs -t -f background-process-worker

destroy:
	docker compose down --rmi all -v --remove-orphans

bash:
	docker compose exec --workdir /home/src background-process-worker /bin/bash

call-client:
	docker compose exec --workdir /home/src -T background-process-worker python background_processes/client.py https://www.google.com
