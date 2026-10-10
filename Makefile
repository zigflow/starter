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
