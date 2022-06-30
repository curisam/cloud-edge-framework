# 프레임워크 구조

- docker 컨테이너를 사용하여 마이크로 아키텍처로 통합 프레임워크가 구성됩니다.



## Server (Cloud)

- server/api
```bash
API 에이전트
```

- server/fl
```bash
연합학습 에이전트 컨테이너
```

- server/vis
```bash
시각화 에이전트 컨테이너
```


## Edge (Client)

- edges/rpi
```bash
라즈베리파이(Raspberrypi)
```

- edges/rpi/rpi4b_8gb
```bash
라즈베리파이4 model-B + 8GB
```

- edges/macbook
```bash
맥북 + 맥OS
```

- edges/jetson
```bash
Nvidia Jetson
```

- edges/jetson/tx2
```bash
Nvidia Jetson TX2
```

- edges/jetson/nano
```bash
Nvidia Jetson NANO
```

## 주요 참고문헌

```bibtex
@article{mathur2021device,
  title={On-device federated learning with flower},
  author={Mathur, Akhil and Beutel, Daniel J and de Gusmao, Pedro Porto Buarque and Fernandez-Marques, Javier and Topal, Taner and Qiu, Xinchi and Parcollet, Titouan and Gao, Yan and Lane, Nicholas D},
  journal={arXiv preprint arXiv:2104.03042},
  year={2021}
}
```


