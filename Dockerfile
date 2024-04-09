# Use a base image with Ubuntu
FROM ubuntu:latest

# Install sudo and OpenSSH server
RUN apt-get update && \
    apt-get install -y sudo openssh-server && \
    rm -rf /var/lib/apt/lists/*

# Generate SSH keys and set permissions
RUN mkdir /var/run/sshd && \
    echo 'root:root' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Create a non-root user with sudo privileges
RUN useradd -m user && echo "user:user" | chpasswd && adduser user sudo

# Expose SSH port
EXPOSE 22

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]
