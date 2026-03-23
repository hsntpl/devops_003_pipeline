#uygulama icin jre
FROM eclipse-temurin:21-jre-alpine
#FROM amazoncorretto:21
#proje jar dosyası
ARG JAR_FILE=target/*.jar

#projenin jar hali docker icine kopyala
COPY ${JAR_FILE} devops-application.jar

#uygulama ic portu sabitle
EXPOSE 8080

#uygulamayı java komutla calistir.
ENTRYPOINT ["java","-jar","devops-application.jar"]