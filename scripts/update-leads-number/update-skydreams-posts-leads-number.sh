#!/bin/bash

#
# This command expects to be run in the wordpress-skydreams root folder.
# It accepts a --homedeal-NL-only flag, to run only for sites related to Homedeal NL markets
#

declare -a homedealTerms=("6 offerte"
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
                          "6 airco offertes"
                          "6 cv-installateurs"
                          "6 cv-installatiebedrijven"
                          "6 dakdekkersbedrijven"
                          "6 gevelbekleding offertes"
                          "6 glasspecialisten"
                          "6 installateurs"
                          "6 kozijnspecialisten"
                          "6 leveranciers"
                          "6 lokale bedrijven"
                          "6 lokale beveiligingsbedrijven"
                          "6 lokale verhuisbedrijven"
                          "6 professionele dakwerkers"
                          "6 rolluiken"
                          "6 schilders"
                          "6 stratenmakers"
                          "6 stucadoors"
                          "6 stukadoorbedrijven"
                          "6 tegelzetters"
                          "6 tuinmannen"
                          "6 vakkundige"
                          "6 verhuisbedrijven"
                          "6 verhuisoffertes"
                          "6 vloerisolatie"
                          "6 vrijblijvende offertes"
                          "6 vrijblijvende prijsopgaves"
                          "tot wel 6"
                          "van maximaal 6"
                          "tot maximaal 6"
                          "Waarom 6"
                          "6 schimmelbestrijding"
                          "6 professionele zonnepanelen"
                          "up to 6")

declare -a zesTerms=("zes offertes"
                      "zes schilders"
                      "zes schildersbedrijven"
                      "zes verschillende"
                      "zes ervaren tegelzetters"
                      "zes tegelzetters"
                      "zes leveranciers"
                      "zes bedrijven"
                      "zes gratis offertes"
                      "zes rolluiken specialisten"
                      "tot maximaal zes ontvangen"
                      "vrijblijvend tot zes")

declare -a nlOnlyTerms=("6 spécialistes"
                    "6 zonnepanelen specialisten"
                    "6 Offertes"
                    "6 verhuisbedrijvenuit"
                    "6 keuzes te staan om het rolluik")


declare -a skydreamsTerms=("6 preventivi"
                            "6 price offers"
                            "6 quotations"
                            "6 quotes"
                            "6 spécialistes"
                            "6 proposte"
                            "6 prospetti"
                            "6 entreprises"
                            "6 offres"
                            "6 aziende"
                            "6 déménageurs"
                            "6 devis"
                            "6 emails from local companies"
                            "6 local companies"
                            "6 emails with competitive quotes"
                            "6 estimates"
                            "6 esperti del settore"
                            "6 estimations d'entreprises"
                            "6 heating companies"
                            "6 movers"
                            "6 moving companies"
                            "6 no obligation quotes"
                            "6 no-obligation quotes"
                            "6 non-binding quotes"
                            "6 offers"
                            "6 preventivi da aziende diverse"
                            "6 professional"
                            "6 quotes"
                            "6 removal specialists"
                            "6 replies in your inbox from local"
                            "6 risposte da aziende"
                            "6 sociétés"
                            "6 trusted, local companies"
                            "6 worldwide removal companies"
                            "6 zonnepanelen specialisten"
                            "6 Offertes"
                            "6 companies"
                            "6 verhuisbedrijvenuit"
                            "6 keuzes te staan om het rolluik")

allTerms=("${homedealTerms[@]}" "${skydreamsTerms[@]}")
dutchTerms=("${homedealTerms[@]}" "${nlOnlyTerms[@]}")


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


declare -a postmetaFields=("intro_text"
                            "content_article"
                            "_yoast_"
                            "features_"
                            "steps_"
                            "_wp_attachment_image_alt")


# We check for a '--homedeal-NL-only' flag passed to the script, in order to run it only for the sites related with Homedeal NL markets
isHomedealNLOnly=false
if [ ${1:-0} == '--homedeal-NL-only' ]; then
    isHomedealNLOnly=true
fi


#
# $1 - additional arguments or flags passed to the command (p. ex. --network or --url)
# $2 - list of tables to replace
# $3 - postmeta table
#
replacePatternInContent () {

    # We need to shift the arguments to avoid including them in the array in the last argument
    commandAddition=$1 && shift
    tablesToReplace=$1 && shift
    postmetaTable=${1:-''} && shift;

    declare -a termsToSearch=("$@")

    for pattern in "${zesTerms[@]}"
    do
        echo "wp search-replace --include-columns=post_content \"$pattern\" \"${pattern/\zes/[default_number_quotes]}\" $commandAddition $tablesToReplace"
        wp search-replace --include-columns=post_content "$pattern" "${pattern/\zes/[default_number_quotes]}" $commandAddition $tablesToReplace
    done


    for pattern in "${termsToSearch[@]}"
    do
        echo "wp search-replace --include-columns=post_content \"$pattern\" \"${pattern/\6/[default_number_quotes]}\" $commandAddition $tablesToReplace"
        wp search-replace --include-columns=post_content "$pattern" "${pattern/\6/[default_number_quotes]}" $commandAddition $tablesToReplace

        # This needs to run separately, because some of the data in the _postmeta tables can't use the shortcode
        if [ ! -z "$postmetaTable" ]; then

            whereClause=''
            for field in "${postmetaFields[@]}"
            do
                 if [ ! -z "$whereClause" ]; then
                    whereClause="$whereClause OR"
                 fi

                whereClause="$whereClause meta_key LIKE \"$field%\""
            done

            echo "wp db query 'UPDATE $postmetaTable SET meta_value = REPLACE(meta_value, \"$pattern\", \"${pattern/\6/4}\") WHERE $whereClause' $commandAddition"
            wp db query "UPDATE $postmetaTable SET meta_value = REPLACE(meta_value, \"$pattern\", \"${pattern/\6/4}\") WHERE $whereClause" ${commandAddition}

        fi
    done
}

if [ "$isHomedealNLOnly" = true ]; then
    for blogId in $(wp site list --allow-root --field=blog_id)
    do
        domain=$(wp site list --site__in=$blogId --field=domain)
        for site in "${homedealSites[@]}"
        do
            if [[ "$domain" == "$site"* ]]; then
                blog_id="$(wp site list --field=blog_id --domain=$domain)"
                replacePatternInContent "--url=$domain" "wp_${blog_id}_posts" "wp_${blog_id}_postmeta" "${dutchTerms[@]}"
            fi
        done
    done
else
    # We first need to check if we're in the right network
    for blogId in $(wp site list --allow-root --field=blog_id)
    do
        domain=$(wp site list --site__in=$blogId --field=domain)
        if [[ "$domain" == "homedeal.nl"* ]]; then
            echo "You're in the wrong folder, please make sure you're in the wordpress-skydreams network"
            exit 0
        fi
    done

    for pattern in "${zesTerms[@]}"
    do
        echo "wp search-replace --include-columns=post_content \"$pattern\" \"${pattern/\zes/[default_number_quotes]}\" --network *_posts"
        wp search-replace --include-columns=post_content "$pattern" "${pattern/\zes/[default_number_quotes]}" --network *_posts
    done

    for pattern in "${allTerms[@]}"
    do
        echo "wp search-replace --include-columns=post_content \"$pattern\" \"${pattern/\6/[default_number_quotes]}\" --network *_posts"
        wp search-replace --include-columns=post_content "$pattern" "${pattern/\6/[default_number_quotes]}" --network *_posts

        # This needs to run separately, because some of the data in the _postmeta tables can't use the shortcode
        for blogId in $(wp site list --allow-root --field=blog_id)
        do
            domain=$(wp site list --site__in=$blogId --field=domain)

            whereClause=''
            for field in "${postmetaFields[@]}"
            do
                 if [ ! -z "$whereClause" ]; then
                    whereClause="$whereClause OR"
                 fi

                whereClause="$whereClause meta_key LIKE \"$field%\""
            done

            echo "wp db query 'UPDATE wp_"${blogId}"_postmeta SET meta_value = REPLACE(meta_value, \"$pattern\", \"${pattern/\6/4}\") WHERE $whereClause' --url=$domain"
            wp db query "UPDATE wp_"${blogId}"_postmeta SET meta_value = REPLACE(meta_value, \"$pattern\", \"${pattern/\6/4}\") WHERE $whereClause" --url=$domain
        done

    done
fi
