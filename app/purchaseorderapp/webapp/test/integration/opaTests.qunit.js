sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'iliyas/po/purchaseorderapp/test/integration/FirstJourney',
		'iliyas/po/purchaseorderapp/test/integration/pages/POsList',
		'iliyas/po/purchaseorderapp/test/integration/pages/POsObjectPage',
		'iliyas/po/purchaseorderapp/test/integration/pages/PurchaseOrderItemsObjectPage'
    ],
    function(JourneyRunner, opaJourney, POsList, POsObjectPage, PurchaseOrderItemsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('iliyas/po/purchaseorderapp') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePOsList: POsList,
					onThePOsObjectPage: POsObjectPage,
					onThePurchaseOrderItemsObjectPage: PurchaseOrderItemsObjectPage
                }
            },
            opaJourney.run
        );
    }
);