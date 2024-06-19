# scripts

## Enable sudo without password

1. `sudo visudo`
2. Replace:

```
%sudo   ALL=(ALL:ALL) ALL
```

with:

```
%sudo   ALL=(ALL:ALL) NOPASSWD:ALL
```
