FROM node:20

RUN apt update --yes
RUN apt upgrade --yes
RUN apt install git
RUN apt install less

RUN npm i -g @angular/cli --loglevel verbose

ENTRYPOINT ["tail", "-f", "/dev/null"]
