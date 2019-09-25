FROM tomcat:8

### Dependencies
RUN apt-get update; apt-get install maven default-jdk -y; update-alternatives --config javac

# Download latest sl
RUN curl -L https://www.shiftleft.io/download/sl-latest-linux-x64.tar.gz | tar xvz -C /usr/local/bin

### Build
COPY . .
RUN mvn clean package ; cp target/*.war /usr/local/tomcat/webapps/

### Analyze

# Shiftleft args
ARG SHIFTLEFT_ORG
ARG SHIFTLEFT_ACCESS_TOKEN

ENV SHIFTLEFT_ORG_ID=$SHIFTLEFT_ORG
ENV SHIFTLEFT_ACCESS_TOKEN=$SHIFTLEFT_ACCESS_TOKEN

RUN sl analyze --app jvl --wait

### Run
CMD ["sl", "run", "catalina.sh","run"]
