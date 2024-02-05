# Use the penultimate stable version of Debian
FROM debian:bullseye

# Installiert NGINX and OpenSSL
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y nginx openssl

# Erstellt ein Verzeichnis für die SSL-Zertifikate im NGINX-Container.
RUN mkdir /etc/nginx/crt

# Generiert ein selbstsigniertes SSL-Zertifikat und einen privaten Schlüssel.
# Die generierten Dateien werden im zuvor erstellten Verzeichnis gespeichert.
# Erzeugt einen neuen RSA-Privatschlüssel mit einer Schlüssellänge von 4096 Bit
# Setzt die Gültigkeitsdauer des Zertifikats auf 365 Tage.
# Gibt den Dateipfad für das generierte Zertifikat an.
# Gibt den Dateipfad für den generierten privaten Schlüssel an.
# Setzt die Informationen für das Zertifikat, Land (C), Ort (L)...
RUN openssl req -newkey rsa:4096 -x509 \
    -days 365 -nodes \
    -out /etc/nginx/crt/vstockma.crt \
    -keyout /etc/nginx/crt/vstockma.key \
    -subj "/C=AT/L=Vienna/O=42/CN=vstockma/"

# Kopiert die nginx.conf Datei und überschreibt die alte, für mehr Anpassungen
COPY ./nginx.conf /etc/nginx/conf.d

EXPOSE 443

# leitet die logs in andere Dateien um. Da sie wegen daemon off nicht in den Terminal geschrieben werden.
# docker logs kann sie abrufen
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

# Startet den NGINX-Server im hintergrund(daemon off)
CMD ["nginx", "-g", "daemon off;"]

