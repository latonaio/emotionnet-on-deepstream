# emotionnet-on-deepstream
emotionnet-on-deepstream は、DeepStream 上で EmotionNet の AIモデル を動作させるマイクロサービスです。  

## 動作環境
- NVIDIA 
    - DeepStream
- EmotionNet
- Docker
- TensorRT Runtime

## EmotionNetについて
EmotionNet は、画像内の顔、顔の主なランドマークを検出し、人間の感情を推測するAIモデルです。

## 動作手順
### Dockerコンテナの起動
Makefile に記載された以下のコマンドにより、EmotionNet の Dockerコンテナ を起動します。
```
docker-run: ## docker container の立ち上げ
	docker-compose up -d
```

### ストリーミングの開始
Makefile に記載された以下のコマンドにより、DeepStream 上の EmotionNet でストリーミングを開始します。  
```
stream-start: ## ストリーミングを開始する
	xhost +
	docker exec -it emotionnet-camera cp /app/mnt/deepstream-emotion-app /app/src/deepstream_tao_apps/apps/tao_others/deepstream-emotion-app/
	docker exec -it emotionnet-camera cp /app/mnt/facedetect.engine /app/src/deepstream_tao_apps/models/faciallandmark/facenet.etlt_b1_gpu0_fp16.engine
	docker exec -it emotionnet-camera cp /app/mnt/faciallandmarks.engine /app/src/deepstream_tao_apps/models/faciallandmark/faciallandmarks.etlt_b32_gpu0_fp16.engine
	docker exec -it emotionnet-camera cp /app/mnt/emotionnet.engine /app/src/deepstream_tao_apps/models/emotion/emotion.etlt_b32_gpu0_fp16.engine
	docker exec -it emotionnet-camera cp /app/mnt/config_infer_primary_facedetect.txt /app/src/deepstream_tao_apps/configs/facial_tao/config_infer_primary_facenet.txt
	docker exec -it emotionnet-camera cp /app/mnt/faciallandmark_sgie_config.txt /app/src/deepstream_tao_apps/configs/facial_tao/faciallandmark_sgie_config.txt
	docker exec -it emotionnet-camera cp /app/mnt/libnvds_emotion_impl.so /app/src/deepstream_tao_apps/apps/tao_others/deepstream-emotion-app/emotion_impl/
	docker exec -it -w /app/src/deepstream_tao_apps/apps/tao_others/deepstream-emotion-app emotionnet-camera \
	       	./deepstream-emotion-app 3 ../../../configs/facial_tao/sample_faciallandmarks_config.txt /dev/video0 emotionnet
```

## 相互依存関係にあるマイクロサービス  
本マイクロサービスを実行するために EmotionNet の AIモデルを最適化する手順は、[emotionnet-on-tao-toolkit](https://github.com/latonaio/emotionnet-on-tao-toolkit)を参照してください。  


## engineファイルについて
engineファイルである emotionnet.engine は、[emotionnet-on-tao-toolkit](https://github.com/latonaio/emotionnet-on-tao-toolkit)と共通のファイルであり、当該レポジトリで作成した engineファイルを、本リポジトリで使用しています。  
