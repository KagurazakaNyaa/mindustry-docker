FROM eclipse-temurin:21
ENV MINDUSTRY_VERSION v146
RUN mkdir /app
RUN mkdir /data
ADD https://github.com/Anuken/Mindustry/releases/download/${MINDUSTRY_VERSION}/server-release.jar /app
EXPOSE 6567/tcp 6567/udp
VOLUME [ "/data" ]
WORKDIR /data
ENTRYPOINT ["java", "-jar", "/app/server-release.jar"]
CMD [ "host" ]