-----------------------------------------------------
# 기술문서

 - 기술문서명 : Edge Vision Cluster(EVC) 상세설계서
 
 - 과제명 : 능동적 즉시 대응 및 빠른 학습이 가능한 적응형 경량 엣지 연동분석 기술개발
 
 - 영문과제명 : Development of Adaptive and Lightweight Edge-Collaborative Analysis Technology for Enabling Proactively Immediate Response and Rapid Learning
 
 - Acknowledgement : This work was supported by Institute of Information & communications Technology Planning & Evaluation (IITP) grant funded by the Korea government(MSIT) (No. 2021-0-00907, Development of Adaptive and Lightweight Edge-Collaborative Analysis Technology for Enabling Proactively Immediate Response and Rapid Learning).
 
 - 작성자 : 박종빈
-----------------------------------------------------

## 문서의 개요

- 본 문서는 Edge Vision Cluster(EVC) 상세설계서 입니다.
- EVC는 클라우드와 에지가 연동하여 비전 처리와 관련한 학습 및 추론을 지원하기 위한 목적으로 개발되고 있습니다.

## EVC의 필요성

### 에지 컴퓨팅

- 에지 컴퓨팅(Edge Computing)은 데이터가 발생하는 현장이나 이러한 데이터소스(Data source) 인근에 에지 디바이스(edge device)가 위치하여 필요한 데이터 처리를 빠르게 수행하는 분산연산처리 방식의 일종입니다. 

- 연산 처리 결과만을 원격지 컴퓨팅 노드들과 공유하거나, 네트워크 연결 없이도 독립적 연산처리를 지원하여 종래의 중앙 집중형 연산처리 방법에 비해 빠른 응답성, 낮은 지연시간, 네트워크 비용 및 전송 시간 절감을 기대할 수 있습니다.

- 이러한 에지 컴퓨팅은 스마트 시티, 스마트 홈, 자율주행차 등 다양한 분야에서 활용가능하고, 분산 컴퓨팅, 머신러닝, 인공지능, 보안 등 다양한 기술과도 융합이 가능합니다.

- 그러나 에지 연산 자원들은 물리적, 논리적으로 서로 분산되어 있고, 기기의 종류도 서로 다를 수 있으므로 기계학습을 수행하고 적절한 응용 기술을 적용하기 위한 새로운 문제점들도 대두됩니다.

- 예컨대, 고성능 클라우드 환경에서는 자원 할당, 연산환경 프로비저닝, 모니터링 및 관리를 중앙에서 일괄 수행하여 접근성, 안정성, 편의성이 높았지만, 이종의 에지 컴퓨팅 환경은 시스템 환경을 구축하고, 지속적으로 모니터링 하는데 상대적 제약이 있습니다.


  따라서 본 논문에서는 물리적으로 분산되고, 네트워크 구성도 이질적이며, 에지 연산자원의 하드웨어 및 소프트웨어 사양도 서로 다른 상황에서 기계학습을 분산 수행하기 위하여 관련 환경을 쉽게 배포하고, 동작 상황과 자원 및 리소스 사용량 등을 실시간으로 모니터링하기 위한 구현 방법을 소개한다. 이를 통해 알고리즘 최적화에 도움이 되고 효율적인 시스템 운영이 가능하게 된다.
  구체적인 자원 모니터링을 위한 방법으로는 오픈소스 도구인 프로메테우스(Prometheus) [2][3]와 그라파나(Grafana) [4]를 사용한다. 프로메테우스는  에지 컴퓨팅 노드들의 연산자원 메트릭을 수집하고 저장하며, 그라파나는 프로메테우스에서 수집한 메트릭을 시각화하고 대시보드에 표시하는 역할을 담당한다. 이런 구성을 통해 에지 연산처리 자원의 CPU, 메모리, 디스크 사용량 등을 실시간으로 모니터링 할 수 있다.
  그리고 이런 모니터링 환경을 각각의 에지 연산처리 장치에 전달하기 위해서 docker 기반으로 패키징하며, 패키징한 이미지를 앤서블(Ansible) [5]로 연계 채널을 구성하여 배포하고 관리할 수 있도록 한다.
  
  
  

## EVC 구성


## EVC 사용예시





