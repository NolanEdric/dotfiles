JUJU_PUBLIC_IP=$(juju config dex-auth public-url)
PUBLIC_IP_NOW="http://$IP"
if [ "$JUJU_PUBLIC_IP" != "$PUBLIC_IP_NOW" ]; then
    juju config dex-auth public-url=$PUBLIC_IP_NOW
    juju config oidc-gatekeeper public-url=$PUBLIC_IP_NOW
fi