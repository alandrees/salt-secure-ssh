#!pyobjects

Grains.present('ed25519_host_key_regen',
               name= 'ed25519_host_key_regenerated',
               value= True)

Grains.present('rsa_4096_host_key_regen',
               name= 'rsa_4096_host_key_regenerated',
               value= True)

Grains.present('removed_system_keys',
               name= 'removed_system_keys',
               value= True)
