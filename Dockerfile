FROM openjdk:8-alpine
MAINTAINER Benjamin Ricaud <benjamin.ricaud@eviacybernetics.com>


# Install tools
RUN apk update && \
	apk add wget unzip git bash

# Install the server
RUN wget --no-check-certificate -O /gremlin.zip https://archive.apache.org/dist/tinkerpop/3.4.2/apache-tinkerpop-gremlin-server-3.4.2-bin.zip && \
	unzip /gremlin.zip -d /gremlin && \
	rm /gremlin.zip
WORKDIR /gremlin/apache-tinkerpop-gremlin-server-3.4.2

# Place where the graph is saved, see gremlin-graph.properties
RUN mkdir /graph_file

EXPOSE 8182

# Copy the configuration files and launch
COPY files .
RUN chmod 700 startup.sh
CMD ["./startup.sh"]
