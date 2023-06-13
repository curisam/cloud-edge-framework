-----------------------------------------------------
# 연구노트 
 - 기술문서명 : kubespray와 연계한 배포 기술 개발
 - 과제명 : 능동적 즉시 대응 및 빠른 학습이 가능한 적응형 경량 엣지 연동분석 기술개발
 - 영문과제명 : Development of Adaptive and Lightweight Edge-Collaborative Analysis Technology for Enabling Proactively Immediate Response and Rapid Learning
 - Acknowledgement : This work was supported by Institute of Information & communications Technology Planning & Evaluation (IITP) grant funded by the Korea government(MSIT) (No. 2021-0-00907, Development of Adaptive and Lightweight Edge-Collaborative Analysis Technology for Enabling Proactively Immediate Response and Rapid Learning).
 - 작성자 : 박종빈
 
 - 날짜 : 2023-06-12 ~ 19
 - 연구자 : 박종빈
-----------------------------------------------------


## 필요성

- 컨네이너화된 워크로드와 서비스를 관리하기 위한 도구로 k8s(kubernetes) 혹은 이것의 경량화 버전 k3s(light weight kubernetes)이 있습니다.

- EVC(Edge Vision Cluster)에서는 계층적 클러스터를 지향하며, 하위 클러스터로 {k8s, k3s} 지원을 추진 중이기 때문에 본 문서를 통해 구체적인 설치 방법 및 특징을 정리하도록 합니다.


### k8s(kubernetes) 특징

- 통상 kubernetes를 약식으로 k8s라고 표기합니다 (k와 s사이에 8글자가 존재합니다).

- 강력한 리소스 추상화, 다양한 관리 방법, 자원 및 상태 모니터링 기능을 제공합니다.

- 그러나 설치가 많이 복잡하고, 설정도 어렵습니다.


### k3s(light weight kubernetes) 특징

- k8s의 일종의 경량화 버전으로써, k8s에서 일종의 DB 역할을 수행하면서 상태정보를 관리하는 etcd의 의존성을 없애고, sqlite DB를 기본으로 씁니다.

- Docker 대신에 containerd와 같은 가벼운 기술을 사용합니다.

- 외부 클라우드와의 연동기능을 최소화하여 의존성을 줄입니다.

- 설치를 위한 쉘 스크립트를 제공하여 대부분의 시스템에서 잘 설치됩니다.

- 예컨데 라즈베리파이 4b 정도의 초경량 연산자원에서도 설치되고 클러스터를 구축할 수 있습니다.

- 그러나 오래된 쿠버네티스 API에 대한 완벽한 하위호환성을 갖지는 않습니다. 



## 설치

- kubespray는 k8s, k3s와 같은 컨테이너 오케스트레이션 시스템을 구축하는데 활용할 수 있는 강력한 도구입니다.

- 유사 기술로는 kubeadm이 있으나 kubespray가 상용품질의 서비스 환경 구축을 위한 보안성과 고가용성 지원에 적합하다는 평가가 있습니다.

- kubespray는 kubeadm처럼 별도의 로드밸런서를 사용하지 않는 대신에 nginx proxy 서버가 존재하여 마스터노드를 보면서 자원 및 상태정보를 서로 공유할 수 있도록 합니다.

- 그리고 ansible과 ssh 연결을 통해 동작하므로 프로비저닝 및 대규모 쿠버네티스 클러스터를 포함한 각종 클라우드 클러스터를 구축하고 관리하기에 적합합니다.

- 그러나 kubespary는 개념은 간결하지만 설치과정은 다소 복잡한 측면이 있습니다.

## 연구 내용

- Port 방화벽 처리 (8000번 포트를 여는 예시)

```bash
$ sudo iptables -I INPUT -p tcp --dport 8000 -j ACCEPT
$ sudo iptables -I OUTPUT -p tcp --sport 8000 -j ACCEPT
```


