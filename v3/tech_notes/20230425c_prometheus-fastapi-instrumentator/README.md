brew install prometheus
brew services start prometheus

vi $(brew --prefix)/etc/prometheus.yml
brew services restart prometheus


## 파이썬 이용해서 메트릭 정보 가져오기

https://pydole.tistory.com/entry/Prometheus-python%EC%9D%84-%EC%9D%B4%EC%9A%A9%ED%95%98%EC%97%AC-metric-%EC%A0%95%EB%B3%B4-%EA%B0%80%EC%A0%B8%EC%98%A4%EA%B8%B0