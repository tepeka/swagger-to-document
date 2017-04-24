FROM asciidoctor/docker-asciidoctor

ENV SM_DIR /Swagger2Markup
ENV SM_VERSION 1.3.1
ENV SM_HOME $SM_DIR/swagger2markup-cli-$SM_VERSION
ENV SM_JAR $SM_HOME/build/libs/swagger2markup-cli-$SM_VERSION.jar

RUN dnf install -y gradle \
 && dnf clean packages

RUN mkdir $SM_DIR \ 
 && wget -q -O $SM_DIR/v$SM_VERSION.tar.gz https://github.com/Swagger2Markup/swagger2markup-cli/archive/v$SM_VERSION.tar.gz \
 && tar xvzf $SM_DIR/v$SM_VERSION.tar.gz -C $SM_DIR \
 && cd $SM_HOME \
 && gradle assemble


CMD ["sh", "-c", "java -jar ${SM_JAR} convert -i swagger.yaml -d generated && asciidoctor-pdf index.adoc"]
