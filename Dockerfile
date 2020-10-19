FROM openjdk:8-alpine
WORKDIR /code
ADD ./target/scala-2.11/akka-http-helloworld-assembly-1.0.jar /code

EXPOSE 8080
CMD java -jar akka-http-helloworld-assembly-1.0.jar