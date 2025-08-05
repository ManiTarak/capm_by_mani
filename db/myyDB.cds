namespace manaDB;

using {manaDB.commons as commons} from './common.cds';
using {cuid,Currency} from '@sap/cds/common';


context master{
    entity businessPartner{
       key NODE_KEY: commons.Guid; 
       BP_ROLE:String(2);
       EMAIL_ADDRESS:String(105);
       PHONE_NUMBER:String(32);
       FAX_NUMBER:String(32);
       WEB_ADDRESS:String(44);
       BP_ID:String(32);
       COMPANY_NAME:String(250);
       ADDRESS_GUID: Association to one address;
    }

    entity address{
        key NODE_KEY: commons.Guid; 
        CITY:String(44);
        POSTAL_CODE:String(8);
        STREET:String(44);
        BUILDING:String(128);
        COUNTRY:String(44);
        ADDRESS_TYPE:String(44);
        VAL_START_DATE:Date;
        VAL_END_DATE:Date;
        LATITUDE: Decimal;
        LONGTITUDE: Decimal;
        businessPartner: Association to one businessPartner on businessPartner.ADDRESS_GUID=$self;
    }

    entity Product{
        key NODE_KEY: commons.Guid;
        PRODUCT_ID:String(28);
        TYPE_CODE:String(2);
        CATEGORY:String(32);
        DESCRIPTION:String(255);
        SUPPLIER_GUID:Association to master.businessPartner;
        TAX_TARIF_CODE:Integer;
        MEASURE_UNIT:String(2);
        WEIGHT_UNIT:String(2);
        WEIGHT_MEASURE: Decimal(5, 2);
        CURRENCY_CODE: String(4);
        PRICE:Decimal(15, 2);
        WIDTH:Decimal(5 , 2);
        DEPTH:Decimal(5, 2);
        DIM_UNIT:String(2);
    }

    entity employee:cuid{
        nameFirst:String(40);
        nameMiddle:String(40);
        nameLast:String(40);
        nameInitials:String(40);
        sex:commons.Gender;
        language:String(1);
        phoneNumber:commons.PhoneNumber;
        email:commons.EmailAddress;
        loginName:String(12);
        Currency:Currency;
        salaryAmount:commons.AmountT;
        accountNumber:String(16);
        bankId:String(8);
        bankName:String(64);

    }

}

context transaction {
    entity purchaseorder:commons.Amount{
        key NODE_KEY:commons.Guid;
        PO_ID:String(40);
        PARTNER_GUID:Association  to master.businessPartner;
        LIFECYCLE_STATUS:String(1);
        OVERALL_STATUS:String(1);
        Items: Association to many poitems on Items.PARENT_KEY=$self;
    }

    entity poitems:commons.Amount{
        key NODE_KEY:commons.Guid;
        PARENT_KEY: Association to purchaseorder;
        PO_ITEM_POS: Integer;
        PRODUCT_GUID: Association to master.Product;
    }
}


