.PHONY: lint update apply

lint:
	find . -name "main.yml" | xargs yamllint -c ./.yamllint.conf ;\
	find . -name "main.yml" | grep -v '^\./main.yml' | xargs -P2 ansible-lint ;\
	find . -name "*.sh" | grep -v 'color_prompt' | xargs shellcheck ;\
	terraform validate

update:
	ansible-playbook ./actions/alpine_update/tasks/main.yml

apply:
	terraform apply --auto-approve ;\
	ansible-playbook ./main.yml
