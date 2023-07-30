FROM searxng/searxng:latest

# Install openssl
RUN apt-get update && apt-get install -y openssl

# Check if "ultrasecretkey" exists in the settings file, if it does, generate and replace with a new key
RUN grep -q "ultrasecretkey" /etc/searxng/settings.yml && openssl rand -hex 64 | xargs -I {} sed -i "s/ultrasecretkey/{}/" /etc/searxng/settings.yml || echo "Key already generated!"

# Uninstall openssl and clean up
RUN apt-get purge -y openssl && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*
