FROM python:alpine

WORKDIR /www/backend

EXPOSE 5000

COPY . .

RUN pip install -r requirements.txt

# set up envs

CMD flask --app main run -p 5000 -h 0.0.0.0