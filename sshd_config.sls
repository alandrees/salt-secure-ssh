#!pyobjects


if not __grains__['removed_system_keys']:
    Cmd.run('ssh-secure-sshd-remove-host-keys',
            name= 'rm /etc/ssh/ssh_host_*')

    Grains.present('removed_system_keys',
               name= 'removed_system_keys',
               value= True)
if not __grains__['ed25519_host_key_regenerated']:
    Cmd.run('ssh-secure-sshd-generate-ed25519-host-key',
            name= 'ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key < /dev/null')

    Grains.present('ed25519_host_key_regen',
                   name= 'ed25519_host_key_regenerated',
                   value= True)

if not __grains__['rsa_4096_host_key_regenerated']:
    Cmd.run('ssh-secure-sshd-generate-rsa-host-key',
            name= 'ssh-keygen -t rsa -b 4096 -f /etc/ssh/ssh_host_rsa_key < /dev/null')

    Grains.present('rsa_4096_host_key_regen',
                   name= 'rsa_4096_host_key_regenerated',
                   value= True)

File.replace('ssh-secure-sshd-remove-old-host-key',
             name= '/etc/ssh/sshd_config',
             pattern= '^HostKey.*\n',
             repl= '')

File.replace('ssh-secure-sshd-disable-password-auth',
             name= '/etc/ssh/sshd_config',
             pattern= '^PasswordAuthenitcation.*\n',
             repl= 'PasswordAuthentication no\n')

File.replace('ssh-secure-sshd-disable-challenge-response-auth',
             name= '/etc/ssh/sshd_config',
             pattern= "^ChallengeResponseAuthentication.*\n",
             repl= "ChallengeResponseAuthentication no\n")

File.append('ssh-secure-sshd-add-rsa-ed25519-host-keys',
             name= '/etc/ssh/sshd_config',
             text= ["HostKey /etc/ssh/ssh_host_rsa_key", "HostKey /etc/ssh/ssh_host_ed25519_key"])

Group.present('ssh-secure-add-ssh-user-group',
              name= 'root',
              addusers= ['ssh-user'])

File.append('ssh-secure-sshd-allow-groups',
            name= '/etc/ssh/sshd_config',
            text= "AllowGroups ssh-user")

File.append('ssh-secure-sshd-key-exchange',
            name= '/etc/ssh/sshd_config',
            text= "KexAlgorithms curve25519-sha256@libssh.org")


File.append('ssh-secure-sshd-cipher-list',
            name= '/etc/ssh/sshd_config',
            text= "Ciphers chacha20-poly1305@openssh.com," +
            "aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr," +
            "aes192-ctr,aes128-ctr")

File.append('ssh-secure-sshd-mac-list',
            name= '/etc/ssh/sshd_config',
            text= "MACs hmac-sha2-512-etm@openssh.com," +
            "hmac-sha2-256-etm@openssh.com,hmac-ripemd160-etm@openssh.com," +
            "umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256," +
            "hmac-ripemd160,umac-128@openssh.com")

Cmd.run('ssh-secure-sshd-restart',
        name= 'systemctl restart ssh')
