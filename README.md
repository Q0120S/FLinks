# FLinks
FLinks is a comprehensive crawling tool that combines efficient active and passive crawling tools.
## Installation
```bash
git clone https://github.com/Q0120S/FLinks.git
cd FLinks
chmod +x install.sh
./install.sh
flinks
```
## Usage
```bash
flinks -h
```
This will display help for the tool. Here are all the switches it supports.
```console
Usage: ./flinks.sh [-k Katana] [-g GAU] [-w Waybackurls] [-s Passive GoSpider] [-r Robifinder] [-u URL] [-l FILE] [-a All] [-o OUTPUT_FILE]
  -u URL: Specify a single URL
  -l FILE: Specify a file containing URLs
  -k: Run katana
  -g: Run gau
  -w: Run waybackurls
  -s: Run passive gospider
  -r: Run robofiner
  -a: Run all
  -o OUTPUT_FILE: Specify an output file to save the results
  Note: Either -u or -l must be provided
```
## Running FLinks
Using active crawling mode
```bash
flinks -u target.com -k 
```
Using passive crawling mode
```bash
flinks -u target.com -gwsr
```
Using comprehensive crawling mode
```bash
flinks -u target.com -a
```
## Current supported tools
* [Katana](https://github.com/projectdiscovery/katana)
* [GAU](https://github.com/lc/gau)
* [Waybackurls](https://github.com/tomnomnom/waybackurls)
* [GoSpider](https://github.com/jaeles-project/gospider)
* Robofinder
    - extract robots.txt paths from [archive.org](https://archive.org)
