# ShiftLeft JVL Docker Demo

### Requirements

* Docker Compose - https://docs.docker.com/compose/install/
* ShiftLeft org ID and token

### Getting started

Build and start the environment.

```
ORG="" TOKEN="" docker-compose up --build
```

Go to http://localhost:8080/JavaVulnerableLab/install.jsp and click _Install_.

### Updating the agent configuration

Edit `docker-compose.yml` and update the `environment` section to modify the
agent's configuration using environment variables.

For example, you can enable **blocking mode** using by setting

```
SHIFTLEFT_SEC_MODE: BLOCK
```
