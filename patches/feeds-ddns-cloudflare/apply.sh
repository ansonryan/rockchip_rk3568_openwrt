#!/bin/bash
# Patch: Add Cloudflare DDNS v4+v6 support to feeds ddns-scripts
# Usage: bash apply.sh (from openwrt root directory)

DDNS_MAKEFILE="feeds/packages/net/ddns-scripts/Makefile"

if [ ! -f "$DDNS_MAKEFILE" ]; then
    echo "Error: $DDNS_MAKEFILE not found. Run from openwrt root."
    exit 1
fi

# Remove the rm line for cloudflare (it deletes the json we want to keep)
sed -i '\#rm $(1)/usr/share/ddns/default/cloudflare.com-v4.json#d' "$DDNS_MAKEFILE"

# Add v6 json install after v4 json install (before endef)
sed -i '/cloudflare.com-v4.json.*INSTALL_DATA/a\	$(INSTALL_DATA) ./files/usr/share/ddns/default/cloudflare.com-v6.json \\' "$DDNS_MAKEFILE"
sed -i '/cloudflare.com-v6.json.*INSTALL_DATA/a\		$(1)/usr/share/ddns/default/' "$DDNS_MAKEFILE"

# Add v6 to services_ipv6 (after v4 line)
sed -i '/cloudflare.com-v4.*services_ipv6/a\	printf "%s\\t%s\\n" '"'"'cloudflare.com-v6'"'"' '"'"'update_cloudflare_com_v4.sh'"'"' >> $${IPKG_INSTROOT}/etc/ddns/services_ipv6' "$DDNS_MAKEFILE"

echo "Cloudflare DDNS patch applied successfully."
