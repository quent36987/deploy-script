
copy:
	@echo "Copy ansible folder (because wsl put drwxrwxrwx on every folder and files)"
	@docker exec -it ansible cp -r /usr/ansible /

vault:
	@echo "Create and chmod vault.txt"
	@docker exec -it ansible chmod 600 .passwords/vault.txt

launch-ovh: copy vault
	@echo "Launch playbook"
	@docker exec -it ansible ansible-playbook ./playbooks/playbook.yml \
        -i inventory/local/hosts \
        -i inventory/server/hosts \
        --vault-password-file .passwords/vault.txt

backup: copy vault
	@echo "Launch playbook"
	@docker exec -it ansible ansible-playbook ./playbooks/backup.yml \
        -i inventory/server/hosts \
        --vault-password-file .passwords/vault.txt
