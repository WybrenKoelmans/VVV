#!/bin/bash

#
# This command expects to be run in the wordpress-skydreams root folder
#

number_quotes=4

declare -a homedealSites=("verhuisoffertes.com"
                            "hekwerk-weetjes.nl"
                            "tegelzetter-weetjes.nl"
                            "gevelreiniging-weetjes.nl"
                            "alarmsysteem-weetjes.nl"
                            "isolatie-weetjes.nl"
                            "cvketel-weetjes.nl"
                            "dakdekker-weetjes.nl"
                            "schilder-weetjes.nl"
                            "stucadoor-weetjes.nl"
                            "zonnepanelen-weetjes.nl"
                            "zonwering-weetjes.nl"
                            "kozijnen-weetjes.nl"
                            "dubbelglas-weetjes.nl"
                            "hovenier-weetjes.nl"
                            "dakkapel-weetjes.nl"
                            "zonwering-weetjes.nl"
                            "rolluiken-weetjes.nl")

for blogId in $(wp site list --allow-root --field=blog_id)
do
    domain=$(wp site list --site__in=$blogId --field=domain)

    # Sets the default_number_quotes to 4 in all homedeal-related sites
    for site in "${homedealSites[@]}"
    do
        if [[ "$domain" == "$site"* ]]; then
            echo "$domain"
            wp theme mod set default_number_quotes ${number_quotes} --url=${domain}
        fi
    done

    # Changes 6 to 4 in specific option values used in the template, on homedeal-related sites
    for site in "${homedealSites[@]}"
    do
        if [[ "$domain" == "$site"* ]]; then
            echo "$domain"

            heading="$(wp option pluck wppress_setting leadform heading --url=${domain})"
            bannerSubheading="$(wp option pluck wppress_setting banner subheading --url=${domain})"
            bottomCtaHeading="$(wp option pluck wppress_setting bottom_cta heading --url=${domain})"
            stickyCtaHeading="$(wp option pluck wppress_setting sticky_cta heading --url=${domain})"
            footer="$(wp option pluck wppress_setting footer description --url=${domain})"

            newHeading=${heading//6/4}
            newBannerSubheading=${bannerSubheading//6/4}
            newBottomCtaHeading=${bottomCtaHeading//6/4}
            newStickyCtaHeading=${stickyCtaHeading//6/4}
            newFooter=${footer//6/4}

            echo "$newHeading"
            echo "$newBannerSubheading"
            echo "$newBottomCtaHeading"
            echo "$newStickyCtaHeading"
            echo "$newFooter"

            wp option patch update wppress_setting leadform heading "${newHeading}" --url=${domain}
            wp option patch update wppress_setting banner subheading "${newBannerSubheading}" --url=${domain}
            wp option patch update wppress_setting bottom_cta heading "${newBottomCtaHeading}" --url=${domain}
            wp option patch update wppress_setting sticky_cta heading "${newStickyCtaHeading}" --url=${domain}
            wp option patch update wppress_setting footer description "${newFooter}" --url=${domain}
        fi
    done
done
