FROM dlang2/dmd-ubuntu
WORKDIR /dlang/app
COPY . .

RUN dub build -v --override-config vibe-d:tls/openssl-1.1
RUN rm /root/.dub -rf
RUN rm /dlang/app/.dub -rf
CMD ["/dlang/app/scoreboard-manipulator"]
