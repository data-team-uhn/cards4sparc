# Cards4SPARC

## Building

To build the Cards4SPARC project, simply run:

```bash
mvn clean install
```

### Building Production-Ready Docker Images

To build a _production-ready_, _self-contained_ Cards4SPARC Docker image,
you will first need to have built a _production-ready_, _self-contained_
generic CARDS Docker image. To do so, enter the `Utilities/Packaging/Docker`
directory in the [generic CARDS repository](https://github.com/data-team-uhn/cards)
and run:

```bash
./build_self_contained.sh ghcr.io/data-team-uhn/cards:latest
```

Once the build of that Docker image completes, enter the root of this
_Cards4SPARC_ repository and run:

```bash
./get_cards4sparc_jars.sh
docker build -t ghcr.io/data-team-uhn/cards4sparc:latest .
```

## Running

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

**Running the following commands requires the use of the --external_cards_project parameter for generate_compose_yaml.py**
**Therefore, it will only work on the CARDS-2349 branch of the CARDS repository until the CARDS-2349 Pull Request is merged**

Enter the main `cards` repository (https://github.com/data-team-uhn/cards)
and build the generic CARDS platform with:

```bash
mvn clean install -Pdocker
```

Then, start the project with:

```bash
cd compose-cluster
python3 generate_compose_yaml.py --dev_docker_image --oak_filesystem --composum --external_cards_project /path/to/local/cards4sparc/repo
docker-compose build
docker-compose up -d
```

Cards4SPARC will be available at http://localhost:8080 once it starts.
