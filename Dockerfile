#uygulama icin jre
FROM eclipse-temurin:21-jre-alpine
#FROM amazoncorretto:21
#proje jar dosyası
ARG JAR_FILE=target/*.jar

#projenin jar hali docker icine kopyala
COPY ${JAR_FILE} hsn_app.jar

#uygulama ic portu sabitle
EXPOSE 8080

#uygulamayı java komutla calistir.
ENTRYPOINT ["java","-jar","hsn_app.jar"]