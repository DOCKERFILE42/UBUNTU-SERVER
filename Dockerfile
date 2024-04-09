# Use a base image with Ubuntu
FROM ubuntu:latest

# Install sudo
RUN apt-get update && \
    apt-get install -y sudo && \
    rm -rf /var/lib/apt/lists/*

# Create a non-root user with sudo privileges
RUN useradd -m user && echo "user:user" | chpasswd && adduser user sudo

# Set the default user to the non-root user
USER user

# Set the working directory to the user's home directory
WORKDIR /home/user

# Set the entry point or default command to run when the container starts
CMD ["bash"]
