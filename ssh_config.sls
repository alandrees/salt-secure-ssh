#!pyobjects

File.append('ssh-secure-ssh-key-exchange',
            name= '/etc/ssh/ssh_config',
            text= """Host *
    KexAlgorithms curve25519-sha256@libssh.org""")

File.append('ssh-secure-ssh-client-auth',
            name= '/etc/ssh/ssh_config',
            text= """Host *
    PasswordAuthentication no
    ChallengeResponseAuthentication no
Host *
    PubkeyAuthentication yes
    HostKeyAlgorithms ssh-ed25519-cert-v01@openssh.com,ssh-rsa-cert-v01@openssh.com,ssh-ed25519,ssh-rsa""")

File.append('ssh-secure-ssh-cipher-list',
            name= '/etc/ssh/ssh_config',
            text= """Host *"
    Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr""")

File.append('ssh-secure-ssh-mac-list',
            name= "/etc/ssh/ssh_config",
            text= """Host *
    MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-ripemd160-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,hmac-ripemd160,umac-128@openssh.com""")

File.append('ssh-secure-ssh-disable-roaming',
            name= '/etc/ssh/ssh_config',
            text= """Host *
    UseRoaming no""")
