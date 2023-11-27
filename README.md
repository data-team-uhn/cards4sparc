# Cards4SPARC

## Building

To build the Cards4SPARC project, first gather the _CARDS-generic_ Maven
artifacts - this step can be skipped if the generic CARDS platform was already built on this machine:

```bash
./get_cards_generic_jars.sh
```

Then run:

```bash
mvn clean install -U
```

### Building Production-Ready Docker Images

A _production-ready_, _self-contained_ Cards4SPARC Docker image,
can be built by running:

```bash
./get_cards4sparc_jars.sh
docker build -t ghcr.io/data-team-uhn/cards4sparc:latest .
```

### Building Development Docker Images

A _development_ Cards4SPARC Docker image can be built by running:

```bash
mkdir -p .m2/repository
docker build -t ghcr.io/data-team-uhn/cards4sparc:latest .
```

This will skip copying any of the built JARs into the Docker image.
Therefore, the resultant image should only be used with the
`--dev_docker_image` and `--cards_generic_jars_repo` flags for
`generate_compose_yaml.py`. This is useful for testing new code during
development as it does not require a new Docker image to be built every
time that code is changed.

## Running

### Production Mode

#### Using Docker Compose

**Please use the `CARDS-2366` branch on the `cards-deploy-tool` repository until it is merged into `master`**

Enter the main `cards-deploy-tool` repository (https://github.com/data-team-uhn/cards-deploy-tool)
and start the project with:

```bash
python3 generate_compose_yaml.py --cards_docker_image cards4sparc:latest --oak_filesystem --composum --smtps
docker-compose build
docker-compose up -d
```

Cards4SPARC will be available at http://localhost:8080 once it starts.



### Development Mode

#### Using `./start_cards.sh`

Enter the main `cards` repository (https://github.com/data-team-uhn/cards)
and build the generic CARDS platform with:

```bash
mvn clean install
```
Then, start the project with:

```bash
./start_cards.sh --dev --project cards4sparc -f mvn:io.uhndata.cards/cards-email-notifications/0.9-SNAPSHOT/slingosgifeature
```

Cards4SPARC will be available at http://localhost:8080 once it starts.

#### Using Docker Compose

**Please use the `CARDS-2366` branch on the `cards-deploy-tool` repository until it is merged into `master`**

Enter the main `cards-deploy-tool` repository (https://github.com/data-team-uhn/cards-deploy-tool)
and start the project with:

```bash
python3 generate_compose_yaml.py --dev_docker_image --cards_generic_jars_repo /path/to/cards4sparc/.cards-generic-mvnrepo --cards_docker_image cards4sparc:latest --oak_filesystem --composum --smtps
docker-compose build
docker-compose up -d
```

Cards4SPARC will be available at http://localhost:8080 once it starts.
