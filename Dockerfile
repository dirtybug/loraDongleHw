FROM debian:trixie-slim
RUN apt-get update && apt-get install -y --no-install-recommends kicad kicad-symbols kicad-footprints python3 python3-reportlab zip ca-certificates && rm -rf /var/lib/apt/lists/*
WORKDIR /work
ENTRYPOINT ["bash","ci/export.sh"]
