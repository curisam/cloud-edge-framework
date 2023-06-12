-----------------------------------------------------
# 연구노트 
 - 기술문서명 : kubespray와 연계한 배포 기술 개발
 - 과제명 : 능동적 즉시 대응 및 빠른 학습이 가능한 적응형 경량 엣지 연동분석 기술개발
 - 영문과제명 : Development of Adaptive and Lightweight Edge-Collaborative Analysis Technology for Enabling Proactively Immediate Response and Rapid Learning
 - Acknowledgement : This work was supported by Institute of Information & communications Technology Planning & Evaluation (IITP) grant funded by the Korea government(MSIT) (No. 2021-0-00907, Development of Adaptive and Lightweight Edge-Collaborative Analysis Technology for Enabling Proactively Immediate Response and Rapid Learning).
 - 작성자 : 박종빈
 
 - 날짜 : 2023-06-12
 - 연구자 : 박종빈
-----------------------------------------------------

## 필요성

- 컨네이너화된 워크로드와 서비스를 관리하기 위한 도구로 k8s(kubernetes)가 존재합니다.
- kubespray는 k8s를 구축하기 위한 지원 도구입니다.
- 단일 시스템에서 다수의 컨네이너를 구동하는 방식으로 쉽게 구성이 가능하다는 장점이 있습니다.
- 도커와 같은 컨테이너 기술과 연계합니다.
- EVC의 계층 클러스터로 k8s 지원을 추진 중입니다.


## 설치

- kubespary 는 개념은 간결하지만 설치과정은 다소 복잡한 측면이 있습니다.


## 연구 내용

- Port 방화벽 처리 (8000번 포트를 여는 예시)

```bash
$ sudo iptables -I INPUT -p tcp --dport 8000 -j ACCEPT
$ sudo iptables -I OUTPUT -p tcp --sport 8000 -j ACCEPT
```
