dev:
	@echo "Starting Zigflow workflows in watch mode"
	@zigflow run \
		--dir ./workflows \
		--glob "**/*.{yaml,yml,json}" \
		--watch
.PHONY: dev

temporal:
	@temporal server start-dev
.PHONY: temporal

validate:
	@find ./workflows -type f \
		\( -name '*.yaml' -o -name '*.yml' -o -name '*.json' \) -print0 \
		| xargs -0 -n1 zigflow validate
.PHONY: validate

############
# Triggers #
############

hello-world:
	@./workflows/hello-world/trigger.sh
.PHONY: hello-world
