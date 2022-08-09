FROM python:3.6.15-slim-buster

WORKDIR app
ADD . . 

RUN pip3 install -r requirements.txt

CMD cd ui && FLASK_APP=ui.py gunicorn ui:app -b 0.0.0.0
