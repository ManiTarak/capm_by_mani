using {manaDB} from '../db/myyDB';

// using {myFirstCdsViews} from '../db/CDS_VIEWS/First_CDS_Example.cds';
service EPMServicre{
    entity EmployeeSet as projection on manaDB.master.employee;
    entity BusinessPartnerSet as projection on manaDB.master.businessPartner;
    entity AddressSet as projection on manaDB.master.address;
    entity ProductSet as projection on manaDB.master.Product;
    entity PurchaseOrderSet as projection on manaDB.transaction.purchaseorder;
    entity PoItemsSet as projection on manaDB.transaction.poitems
    actions{
        action boundedFunction() returns String;
        function largestOrder() returns String;
    };

    // entity POWorkList as projection on myFirstCdsViews.POWorkList;
}