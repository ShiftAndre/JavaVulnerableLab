### ShiftLeft stage
FROM tomcat:8 AS shiftleft-stage

# Shiftleft args
ENV SHIFTLEFT_ORG
ENV SHIFTLEFT_ACCESS_TOKEN

# Download latest sl
RUN curl -L https://www.shiftleft.io/download/sl-latest-linux-x64.tar.gz | tar xvz -C /usr/local/bin
# Configure sl
RUN sl --no-diagnostic auth --org "$SHIFTLEFT_ORG" --token "$SHIFTLEFT_ACCESS_TOKEN"

FROM tomcat:8

### Copy ShiftLeft config
COPY --from=shiftleft-stage /usr/local/bin/sl /usr/local/bin/sl
COPY --from=shiftleft-stage /root/.shiftleft /root/.shiftleft

### Dependencies
RUN apt-get update; apt-get install maven default-jdk -y; update-alternatives --config javac

### Build
COPY . .
RUN mvn clean package ; cp target/*.war /usr/local/tomcat/webapps/

### Analyze
RUN sl analyze --app jvl --wait

### Run
CMD ["sl", "run", "catalina.sh","run"]
