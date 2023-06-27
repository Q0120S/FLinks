#!/bin/bash

go install github.com/projectdiscovery/katana/cmd/katana@latest
go install github.com/lc/gau/v2/cmd/gau@latest
go install github.com/tomnomnom/waybackurls@latest
go install github.com/jaeles-project/gospider@latest
go install github.com/tomnomnom/anew@latest
chmod +x flinks.sh
cp flinks.sh /usr/bin/flinks
