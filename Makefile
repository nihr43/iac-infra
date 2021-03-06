.PHONY: lint update apply

lint:
	find . -name "main.yml" | xargs yamllint -c ./.yamllint.conf &&\
	find ./scripts/ -name "*.sh" | xargs shellcheck &&\
	ansible-lint ./main.yml -x 305,403,503 &&\
	terraform validate

update:
	ansible-playbook ./actions/alpine_update/tasks/main.yml

apply:
	terraform apply --auto-approve &&\
	ansible-playbook ./main.yml
