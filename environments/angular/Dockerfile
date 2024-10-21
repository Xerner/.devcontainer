FROM node:latest

RUN apt update --yes
RUN apt upgrade --yes
RUN apt install git
RUN apt install less

RUN npm install -g @angular/cli

ENTRYPOINT ["tail", "-f", "/dev/null"]
