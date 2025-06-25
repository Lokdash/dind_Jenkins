FROM tomcat:9.0.8-jre8
COPY ./target/hello-1.0.war /var/lib/tomcat9/webapps/hello-1.0
EXPOSE 8080
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]
