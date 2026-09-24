# Nginx load balancer and local TLS

Local Docker Compose lab: one TLS-terminating proxy distributes requests across three static Nginx backends using round-robin balancing. Requires Docker Compose and OpenSSL on the host.

## Start from a fresh clone

```bash
bash scripts/generate-cert.sh
docker compose up -d
```

The private key and certificate are generated locally and excluded from Git. Existing certificates are never overwritten by the script. The certificate expires after 30 days and is self-signed, for local testing only.

## Verify

```bash
# Location must be https://localhost:8443/ (the published TLS port).
curl -I http://localhost:8080/
# Trust this lab certificate explicitly; inspect the different backend responses.
for i in {1..6}; do curl --cacert certs/selfsigned.crt https://localhost:8443/; done
curl --cacert certs/selfsigned.crt https://localhost:8443/health
```

`/health` verifies the proxy itself, not the health of the upstream pool. Ports bind to loopback. Change both the Compose mapping and redirect if using a different external TLS port.

## Cleanup

```bash
docker compose down
```

For production, configure a real domain and trusted certificate with renewal, upstream failure checks, resource limits and monitoring. This lab is not a production deployment.
