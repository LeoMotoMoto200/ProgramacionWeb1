# Usar la imagen base de Minideb
FROM bitnami/minideb:latest

ENV DEBIAN_FRONTEND="noninteractive" 

# Actualización e instalación de dependencias
RUN apt-get update && \
    apt-get install -y apache2 perl libcgi-pm-perl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Habilitar el módulo CGI en Apache
RUN a2enmod cgi

# Crear las carpetas necesarias de forma explícita
RUN mkdir -p /usr/lib/cgi-bin
RUN mkdir -p /var/www/html

# Copiar los scripts Perl de la carpeta 'cgi-bin' al directorio cgi-bin
COPY Otros_archivos/cgi-bin/*.pl /usr/lib/cgi-bin/

# Copiar los scripts Perl de la carpeta 'cgi-bin' al directorio cgi-bin
COPY Otros_archivos/html/*.html /var/www/html/


# Configuración de permisos
RUN chmod +x /usr/lib/cgi-bin/*.pl
RUN chmod -R 755 /usr/lib/cgi-bin/*
RUN chmod 755 /var/www/html/*.html

# Establecer el ServerName para evitar la advertencia
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Exponer el puerto 80
EXPOSE 80

# Iniciar Apache en primer plano
CMD ["apache2ctl", "-D", "FOREGROUND"]