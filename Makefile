# Self-Documented Makefile
# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

tao-docker-run: ## TAO用コンテナを建てる
	docker-compose -f docker-compose.yaml up -d

tao-docker-build: ## TAO用コンテナをビルド
	docker-compose -f docker-compose.yaml build

tao-convert:
	docker exec -it emotionnet-tao-toolkit tao-converter -k nvidia_tlt -t fp16 \
		-p input_landmarks:0,1x1x136x1,32x1x136x1,32x1x136x1 -e /app/src/emotionnet.engine /app/src/model.etlt

tao-docker-login: ## TAO用コンテナにログイン
	docker exec -it emotionnet-tao-toolkit bash

