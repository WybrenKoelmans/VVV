#!/usr/bin/env bash

if [ "$1" = "--test" ]; then
    env=".test.skydreams.com"
elif [ "$1" = "--prod" ]; then
    env=""
else
    env=".dev.skydreams.com"
fi

dutchThankYouPage="Offertes"
italianThankYouPage="Preventivi"
englishThankYouPage="FreeQuotes"
frenchThankYouPage="Devis"

wp option patch update wppress_setting leadform thank-you-page ${dutchThankYouPage} --url=verhuisoffertes.com${env}
wp option patch update wppress_setting leadform thank-you-page ${italianThankYouPage} --url=infissi365.it${env}
wp option patch update wppress_setting leadform thank-you-page ${italianThankYouPage} --url=pannelli-solari24.it${env}
wp option patch update wppress_setting leadform thank-you-page ${englishThankYouPage} --url=getawindow.co.uk${env}
wp option patch update wppress_setting leadform thank-you-page ${dutchThankYouPage} --url=be.verhuisoffertes.com${env}
wp option patch update wppress_setting leadform thank-you-page ${englishThankYouPage} --url=getamover.co.uk${env}
wp option patch update wppress_setting leadform thank-you-page ${italianThankYouPage} --url=edilizia365.it${env}
wp option patch update wppress_setting leadform thank-you-page ${italianThankYouPage} --url=traslochi24.it${env}
wp option patch update wppress_setting leadform thank-you-page ${englishThankYouPage} --url=getagardener.co.uk${env}
wp option patch update wppress_setting leadform thank-you-page ${englishThankYouPage} --url=centralheating-quotes.com${env}
wp option patch update wppress_setting leadform thank-you-page ${englishThankYouPage} --url=window24.ie${env}
wp option patch update wppress_setting leadform thank-you-page ${englishThankYouPage} --url=getamover.ie${env}
wp option patch update wppress_setting leadform thank-you-page ${italianThankYouPage} --url=giardinieri-24.it${env}
wp option patch update wppress_setting leadform thank-you-page ${frenchThankYouPage} --url=demenagement24.com${env}
wp option patch update wppress_setting leadform thank-you-page ${italianThankYouPage} --url=imbianchini365.it${env}
