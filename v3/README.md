# 설치

## jupyter-lab을 iframe으로 열기

```bash
$ jupyter-lab --generate-config

$ vi .jupyter/jupyter_lab_config.py 
```

- 코드 추가

```bash
   c.NotebookApp.tornado_settings={'headers': {'Content-Security-Policy': "frame-ancestors * 'self' "}}
```

## RPI 에서 jupyter-lab