FROM asciidoctor/docker-asciidoctor

ENV SM_DIR /Swagger2Markup
ENV SM_HOME $SM_DIR/swagger2markup-cli-1.3.1
ENV SM_JAR $SM_HOME/build/libs/swagger2markup-cli-1.3.1.jar

RUN dnf install -y gradle \
 && dnf clean packages

RUN mkdir $SM_DIR \ 
 && wget -q -O $SM_DIR/v1.3.1.tar.gz https://github.com/Swagger2Markup/swagger2markup-cli/archive/v1.3.1.tar.gz \
 && tar xvzf $SM_DIR/v1.3.1.tar.gz -C $SM_DIR \
 && cd $SM_HOME \
 && gradle assemble


CMD ["sh", "-c", "java -jar ${SM_JAR} convert -i swagger.yaml -d generated && asciidoctor-pdf index.adoc"]
