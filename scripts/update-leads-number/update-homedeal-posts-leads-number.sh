#!/bin/bash

#
# This command expects to be run in the Homedeal wordpress root folder
#


declare -a homedealTerms=("6 offerte"
                          "6  offertes"
                          "6 verschillende"
                          "6 betrouwbare"
                          "6 gratis"
                          "6 specialisten"
                          "6 hoveniers"
                          "6 erkende hoveniersbedrijven"
                          "6 geselecteerde hoveniers"
                          "6 bedrijven"
                          "6 aannemer offertes"
                          "6 dakkapel"
                          "6 prijsopgave"
                          "6 diverse prijsopgaves"
                          "6 aanbieders"
                          "6 aanbiedingen"
                          "6 aanbouw offers"
                          "6 airco offertes"
                          "6 aluminium serre offertes"
                          "6 architectoffertes"
                          "6 architect offertes"
                          "6 asbestsaneringspecialisten"
                          "6 badkamer offertes"
                          "6 bestrating offertes"
                          "6 buitenzonwering"
                          "6 cv-installateurs"
                          "6 cv-installatiebedrijven"
                          "6 cv-ketel offertes"
                          "6 dakbedekking offertes"
                          "6 dakdekkersbedrijven"
                          "6 garagedeur offertes"
                          "6 geschikte trapspecialisten"
                          "6 geschikte garagedeur-specialisten"
                          "6 geschikte ongediertebestrijding-specialisten"
                          "6 gevelbekleding offertes"
                          "6 glasspecialisten"
                          "6 glaszetter offertes"
                          "6 gevonden schildersbedrijven"
                          "6 installateurs"
                          "6 interieuradvies"
                          "6 keukenoffertes"
                          "6 knikarmscherm-offertes"
                          "6 kozijnspecialisten"
                          "6 leveranciers"
                          "6 lokale bedrijven"
                          "6 lokale beveiligingsbedrijven"
                          "6 lokale verhuisbedrijven"
                          "6 loodgieter offertes"
                          "6 markiezen-offertes"
                          "6 ongediertebestrijding"
                          "6 professionele dakwerkers"
                          "6 rolluiken"
                          "6 schilders"
                          "6 schilderwerk offertes"
                          "6 schuifpui-offertes"
                          "6 schuifpui offertes"
                          "6 screen-offertes"
                          "6 serre offertes"
                          "6 serre specialisten"
                          "6 shutters offertes"
                          "6 stratenmakers"
                          "6 stucadoors"
                          "6 stukadoorbedrijven"
                          "6 tegelzetters"
                          "6 tegelzetter offertes"
                          "6 trap-offertes"
                          "6 trap offertes"
                          "6 tuinmannen"
                          "6 uitvalscherm offertes"
                          "6 vakkundige"
                          "6 verhuisbedrijven"
                          "6 verhuisoffertes"
                          "6 vloerverwarming-offertes"
                          "6 vrijblijvende offertes"
                          "6 vrijblijvende prijsopgaves"
                          "6 vochtbestrijdingoffertes"
                          "6 vochtbestrijding offertes"
                          "6 vochtspecialisten"
                          "6 schimmelbestrijding"
                          "6 zonnescherm-offertes"
                          "6 zonnepanelen specialisten"
                          "6 zonnepanelen offertes"
                          "6 zonweringoffertes"
                          "6 zonwering offertes"
                          "Vraag tot 6"
                          "tot wel 6"
                          "van maximaal 6"
                          "tot maximaal 6"
                          "tot 6  offertes"
                          "maximaal 6 professionele"
                          "prijsoffertes. Waarom 6"
                          "6 schimmelbestrijding"
                          "6 professionele zonnepanelen"
                          "maximaal 6 geschikte"
                          "up to 6")


for blogId in $(wp site list --allow-root --field=blog_id)
do
    domain=$(wp site list --site__in=$blogId --field=domain)

    # This will only be used for homedeal.nl for now
    if [[ "$domain" == "homedeal.nl"* ]]; then

        for pattern in "${homedealTerms[@]}"
        do
            echo "wp search-replace --include-columns=post_content \"$pattern\" \"${pattern/\6/[default_number_quotes]}\" --url=$domain wp_${blogId}_posts"
            wp search-replace --include-columns=post_content "$pattern" "${pattern/\6/[default_number_quotes]}" --url=$domain wp_${blogId}_posts

            # This needs to run separately, because some of the data in the _postmeta and _termmeta tables can't use the shortcode

            whereClause="(meta_key LIKE \"sd_%\" OR meta_key LIKE \"_yoast_%\" OR meta_key = \"_wp_attachment_image_alt\")"
            whereClause="$whereClause AND LENGTH(meta_value) > 6"

            echo "wp db query 'UPDATE wp_${blogId}_postmeta SET meta_value = REPLACE(meta_value, \"$pattern\", \"${pattern/\6/4}\") WHERE $whereClause' --url=$domain"
            wp db query "UPDATE wp_${blogId}_postmeta SET meta_value = REPLACE(meta_value, \"$pattern\", \"${pattern/\6/4}\") WHERE $whereClause" --url=${domain}

            echo "wp db query 'UPDATE wp_${blogId}_termmeta SET meta_value = REPLACE(meta_value, \"$pattern\", \"${pattern/\6/4}\") WHERE $whereClause' "--url=$domain""
            wp db query "UPDATE wp_${blogId}_termmeta SET meta_value = REPLACE(meta_value, \"$pattern\", \"${pattern/\6/4}\") WHERE $whereClause" --url=${domain}

        done
    fi
done
