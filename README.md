# emotionnet-on-tao-toolkit
emotionnet-on-tao-toolkit は、NVIDIA TAO TOOLKIT を用いて EmotionNet の AIモデル最適化を行うマイクロサービスです。  

## 動作環境
- NVIDIA 
    - TAO TOOLKIT
- EmotionNet
- Docker
- TensorRT Runtime

## EmotionNetについて
EmotionNet は、画像内の顔、顔の主なランドマークを検出し、人間の感情を推測するAIモデルです。

## 動作手順

### engineファイルの生成
EmotionNet のAIモデルをデバイスに最適化するため、 EmotionNet の .etlt ファイルを engine file に変換します。
engine fileへの変換は、Makefile に記載された以下のコマンドにより実行できます。

```
tao-convert:
	docker exec -it emotionnet-tao-toolkit tao-converter -k nvidia_tlt -t fp16 \
		-p input_landmarks:0,1x1x136x1,32x1x136x1,32x1x136x1 -e /app/src/emotionnet.engine /app/src/model.etlt
```

## 相互依存関係にあるマイクロサービス  
本マイクロサービスで最適化された EmotionNet の AIモデルを Deep Stream 上で動作させる手順は、[emotionnet-on-deepstream](https://github.com/latonaio/emotionnet-on-deepstream)を参照してください。  

## engineファイルについて
engineファイルである emotionnet.engine は、[emotionnet-on-deepstream](https://github.com/latonaio/emotionnet-on-deepstream)と共通のファイルであり、本レポジトリで作成した engineファイルを、当該リポジトリで使用しています。  
