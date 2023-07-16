#!/bin/bash

# Define color codes
GREEN='\033[0;32m'
RESET='\033[0m' # Reset color

# Function to display script usage
display_usage() {
    echo "Usage: $0 [-k Katana] [-g GAU] [-w Waybackurls] [-s Passive GoSpider] [-r Robifinder] [-u URL] [-l FILE] [-a All] [-o OUTPUT_FILE]"
    echo "  -u URL: Specify a single URL"
    echo "  -l FILE: Specify a file containing URLs"
    echo "  -k: Run katana"
    echo "  -g: Run gau"
    echo "  -w: Run waybackurls"
    echo "  -s: Run passive gospider"
    echo "  -r: Run robofiner"
    echo "  -a: Run all"
    echo "  -o OUTPUT_FILE: Specify an output file to save the results"
    echo "  Note: Either -u or -l must be provided"
}

# Variables
run_katana=false
run_gau=false
run_waybackurls=false
run_passive_gospider=false
run_robofinder=false
url=""
file=""
output_file=""

# Parse command line arguments
while getopts ":akgwsru:l:o:" option; do
    case "${option}" in
        a)
            run_katana=true
            run_gau=true
            run_waybackurls=true
            run_passive_gospider=true
            run_robofinder=true
            ;;
        k)
            run_katana=true
            ;;
        g)
            run_gau=true
            ;;
        w)
            run_waybackurls=true
            ;;
        s)
            run_passive_gospider=true
            ;;
        r)
            run_robofinder=true
            ;;
        u)
            url="${OPTARG}"
            ;;
        l)
            file="${OPTARG}"
            ;;
        o)
            output_file="${OPTARG}"
            ;;
        *)
            display_usage
            exit 1
            ;;
    esac
done

# Check if either URL or file is provided
if [[ -z "$url" && -z "$file" ]]; then
    echo "Error: Either -u or -l must be provided"
    display_usage
    exit 1
fi

# Check if at least one tool is selected
if [[ "$run_katana" == false && "$run_gau" == false && "$run_waybackurls" == false && "$run_passive_gospider" == false && "$run_robofinder" == false ]]; then
    echo "Error: At least one tool (-k, -g, -w, -s or -r) must be selected"
    display_usage
    exit 1
fi

# Run katana
if "$run_katana"; then
    echo -e "${GREEN}[Katana is running]${RESET}"
    if [[ -n "$url" ]]; then
        if [[ -n "$output_file" ]]; then
            host=$(echo "$url" | unfurl format %d)
            echo "$url" | katana -js-crawl -known-files -automatic-form-fill -silent --no-sandbox -headless -crawl-scope "$host" -extension-filter css,jpg,jpeg,png,svg,img,gif,mp4,flv,pdf,doc,ogv,webm,wmv,webp,mov,mp3,m4a,m4p,ppt,pptx,scss,tif,tiff,ttf,otf,woff,woff2,bmp,ico,eot,htc,swf,rtf,image | sort -u | anew "$output_file"
        else
            host=$(echo "$url" | unfurl format %d)
            echo "$url" | katana -js-crawl -known-files -automatic-form-fill -silent --no-sandbox -headless -crawl-scope "$host" -extension-filter css,jpg,jpeg,png,svg,img,gif,mp4,flv,pdf,doc,ogv,webm,wmv,webp,mov,mp3,m4a,m4p,ppt,pptx,scss,tif,tiff,ttf,otf,woff,woff2,bmp,ico,eot,htc,swf,rtf,image | sort -u
        fi
    else
        if [[ -n "$output_file" ]]; then
            while IFS= read -r line; do
                host=$(echo "$line" | unfurl format %d)
                echo "$line" | katana -js-crawl -known-files -automatic-form-fill -silent --no-sandbox -headless -extension-filter css,jpg,jpeg,png,svg,img,gif,mp4,flv,pdf,doc,ogv,webm,wmv,webp,mov,mp3,m4a,m4p,ppt,pptx,scss,tif,tiff,ttf,otf,woff,woff2,bmp,ico,eot,htc,swf,rtf,image | sort -u
            done < "$file" | anew "$output_file"
        else
            while IFS= read -r line; do
                host=$(echo "$line" | unfurl format %d)
                echo "$line" | katana -js-crawl -known-files -automatic-form-fill -silent --no-sandbox -headless -extension-filter css,jpg,jpeg,png,svg,img,gif,mp4,flv,pdf,doc,ogv,webm,wmv,webp,mov,mp3,m4a,m4p,ppt,pptx,scss,tif,tiff,ttf,otf,woff,woff2,bmp,ico,eot,htc,swf,rtf,image | sort -u
            done < "$file"
        fi
    fi
fi

# Run gau
if "$run_gau"; then
    echo -e "${GREEN}[GAU is running]${RESET}"
    if [[ -n "$url" ]]; then
        if [[ -n "$output_file" ]]; then
            echo "$url" | gau | grep -Eiv '\.(css|jpg|jpeg|png|svg|img|gif|exe|mp4|flv|pdf|doc|ogv|webm|wmv|webp|mov|mp3|m4a|m4p|ppt|pptx|scss|tif|tiff|ttf|otf|woff|woff2|bmp|ico|eot|htc|swf|rtf|image|rf)' | sort -u | anew "$output_file"
        else
            echo "$url" | gau | grep -Eiv '\.(css|jpg|jpeg|png|svg|img|gif|exe|mp4|flv|pdf|doc|ogv|webm|wmv|webp|mov|mp3|m4a|m4p|ppt|pptx|scss|tif|tiff|ttf|otf|woff|woff2|bmp|ico|eot|htc|swf|rtf|image|rf)' | sort -u
        fi
    else
        if [[ -n "$output_file" ]]; then
            cat "$file" | gau | grep -Eiv '\.(css|jpg|jpeg|png|svg|img|gif|exe|mp4|flv|pdf|doc|ogv|webm|wmv|webp|mov|mp3|m4a|m4p|ppt|pptx|scss|tif|tiff|ttf|otf|woff|woff2|bmp|ico|eot|htc|swf|rtf|image|rf)' | sort -u | anew "$output_file"
        else
            cat "$file" | gau | grep -Eiv '\.(css|jpg|jpeg|png|svg|img|gif|exe|mp4|flv|pdf|doc|ogv|webm|wmv|webp|mov|mp3|m4a|m4p|ppt|pptx|scss|tif|tiff|ttf|otf|woff|woff2|bmp|ico|eot|htc|swf|rtf|image|rf)' | sort -u
        fi
    fi
fi

# Run waybackurls
if "$run_waybackurls"; then
    echo -e "${GREEN}[Waybackurls is running]${RESET}"
    if [[ -n "$url" ]]; then
        if [[ -n "$output_file" ]]; then
            echo "$url" | waybackurls | grep -Eiv '\.(css|jpg|jpeg|png|svg|img|gif|exe|mp4|flv|pdf|doc|ogv|webm|wmv|webp|mov|mp3|m4a|m4p|ppt|pptx|scss|tif|tiff|ttf|otf|woff|woff2|bmp|ico|eot|htc|swf|rtf|image|rf)' | sort -u | anew "$output_file"
        else
            echo "$url" | waybackurls | grep -Eiv '\.(css|jpg|jpeg|png|svg|img|gif|exe|mp4|flv|pdf|doc|ogv|webm|wmv|webp|mov|mp3|m4a|m4p|ppt|pptx|scss|tif|tiff|ttf|otf|woff|woff2|bmp|ico|eot|htc|swf|rtf|image|rf)' | sort -u
        fi
    else
        if [[ -n "$output_file" ]]; then
            cat "$file" | waybackurls | grep -Eiv '\.(css|jpg|jpeg|png|svg|img|gif|exe|mp4|flv|pdf|doc|ogv|webm|wmv|webp|mov|mp3|m4a|m4p|ppt|pptx|scss|tif|tiff|ttf|otf|woff|woff2|bmp|ico|eot|htc|swf|rtf|image|rf)' | sort -u | anew "$output_file"
        else
            cat "$file" | waybackurls | grep -Eiv '\.(css|jpg|jpeg|png|svg|img|gif|exe|mp4|flv|pdf|doc|ogv|webm|wmv|webp|mov|mp3|m4a|m4p|ppt|pptx|scss|tif|tiff|ttf|otf|woff|woff2|bmp|ico|eot|htc|swf|rtf|image|rf)' | sort -u
        fi
    fi
fi

# Run passive gospider
if "$run_passive_gospider"; then
    echo -e "${GREEN}[Passive GoSpider is running]${RESET}"
    if [[ -n "$url" ]]; then
        if [[ -n "$output_file" ]]; then
            sudo -- sh -c "echo '127.0.0.1 "$url"' >> /etc/hosts"
            echo https://"$url" | gospider --other-source --include-subs --subs --quiet | grep -Eiv '\.(css|jpg|jpeg|png|svg|img|gif|exe|mp4|flv|pdf|doc|ogv|webm|wmv|webp|mov|mp3|m4a|m4p|ppt|pptx|scss|tif|tiff|ttf|otf|woff|woff2|bmp|ico|eot|htc|swf|rtf|image|rf)' | sort -u  | grep -Eo 'https?://[^ ]+' | sed 's/]$//' | anew "$output_file"
            sudo -- sh -c "sed -i '/127.0.0.1 "$url"/d' /etc/hosts"
        else
            sudo -- sh -c "echo '127.0.0.1 "$url"' >> /etc/hosts"
            echo https://"$url" | gospider --other-source --include-subs --subs --quiet | grep -Eiv '\.(css|jpg|jpeg|png|svg|img|gif|exe|mp4|flv|pdf|doc|ogv|webm|wmv|webp|mov|mp3|m4a|m4p|ppt|pptx|scss|tif|tiff|ttf|otf|woff|woff2|bmp|ico|eot|htc|swf|rtf|image|rf)' | sort -u | grep -Eo 'https?://[^ ]+' | sed 's/]$//'
            sudo -- sh -c "sed -i '/127.0.0.1 "$url"/d' /etc/hosts"
        fi
    else
        if [[ -n "$output_file" ]]; then
            while IFS= read -r line; do
                sudo -- sh -c "echo '127.0.0.1 $line' >> /etc/hosts"
                echo "https://$line" | gospider --other-source --include-subs --subs --quiet | grep -Eiv '\.(css|jpg|jpeg|png|svg|img|gif|exe|mp4|flv|pdf|doc|ogv|webm|wmv|webp|mov|mp3|m4a|m4p|ppt|pptx|scss|tif|tiff|ttf|otf|woff|woff2|bmp|ico|eot|htc|swf|rtf|image|rf)' | sort -u | grep -Eo 'https?://[^ ]+' | sed 's/]$//' | anew "$output_file"
                sudo -- sh -c "sed -i '/127.0.0.1 $line/d' /etc/hosts"
            done < "$file"
        else
            while IFS= read -r line; do
                sudo -- sh -c "echo '127.0.0.1 $line' >> /etc/hosts"
                echo "https://$line" | gospider --other-source --include-subs --subs --quiet | grep -Eiv '\.(css|jpg|jpeg|png|svg|img|gif|exe|mp4|flv|pdf|doc|ogv|webm|wmv|webp|mov|mp3|m4a|m4p|ppt|pptx|scss|tif|tiff|ttf|otf|woff|woff2|bmp|ico|eot|htc|swf|rtf|image|rf)' | sort -u | grep -Eo 'https?://[^ ]+' | sed 's/]$//'
                sudo -- sh -c "sed -i '/127.0.0.1 $line/d' /etc/hosts"
            done < "$file"
        fi
    fi
fi

# Run robofinder
if "$run_robofinder"; then
    echo -e "${GREEN}[Robifinder is running]${RESET}"
    if [[ -n "$url" ]]; then
        if [[ -n "$output_file" ]]; then
            url="$url" 
            timestamps=$(curl -s "https://web.archive.org/cdx/search/cdx?url=$url/robots.txt&filter=statuscode:200&fl=timestamp,original&collapse=digest" | awk '{print $1}' | sort -r)
            for timestamp in $(echo $timestamps)
            do
                curl -sk "https://web.archive.org/web/$(echo $timestamp)if_/$url/robots.txt" | awk '/^Allow:|^Disallow:/ {print $2}' | sed "s|^|https://$url|" | anew 
                curl -sk "https://web.archive.org/web/$(echo $timestamp)if_/$url/robots.txt" | awk '/^Sitemap:/ {print $2}' | anew
            done | sort -u | tee -a "$output_file"
        else
            url="$url"
            timestamps=$(curl -s "https://web.archive.org/cdx/search/cdx?url=$url/robots.txt&filter=statuscode:200&fl=timestamp,original&collapse=digest" | awk '{print $1}' | sort -r)
            for timestamp in $(echo $timestamps)
            do
                curl -sk "https://web.archive.org/web/$(echo $timestamp)if_/$url/robots.txt" | awk '/^Allow:|^Disallow:/ {print $2}' | sed "s|^|https://$url|" | anew
                curl -sk "https://web.archive.org/web/$(echo $timestamp)if_/$url/robots.txt" | awk '/^Sitemap:/ {print $2}' | anew
            done | anew
        fi
    else
        if [[ -n "$output_file" ]]; then
            while IFS= read -r line; do
                url=$line
                timestamps=$(curl -s "https://web.archive.org/cdx/search/cdx?url=$url/robots.txt&filter=statuscode:200&fl=timestamp,original&collapse=digest" | awk '{print $1}' | sort -r)
                for timestamp in $(echo $timestamps)
                do
                    curl -sk "https://web.archive.org/web/$(echo $timestamp)if_/$url/robots.txt" | awk '/^Allow:|^Disallow:/ {print $2}' | sed "s|^|https://$url|" | anew
                    curl -sk "https://web.archive.org/web/$(echo $timestamp)if_/$url/robots.txt" | awk '/^Sitemap:/ {print $2}' | anew
                done
            done < "$file" | sort -u | tee -a "$output_file"
        else
            while IFS= read -r line; do
                url=$line
                timestamps=$(curl -s "https://web.archive.org/cdx/search/cdx?url=$url/robots.txt&filter=statuscode:200&fl=timestamp,original&collapse=digest" | awk '{print $1}' | sort -r)
                for timestamp in $(echo $timestamps)
                do
                    curl -sk "https://web.archive.org/web/$(echo $timestamp)if_/$url/robots.txt" | awk '/^Allow:|^Disallow:/ {print $2}' | sed "s|^|https://$url|" | anew
                    curl -sk "https://web.archive.org/web/$(echo $timestamp)if_/$url/robots.txt" | awk '/^Sitemap:/ {print $2}' | anew
                done | anew
            done < "$file"
        fi
    fi
fi
