namespace myFirstCdsViews;
using {manaDB} from '../myyDB';

define view ![POWorkList] as select from manaDB.transaction.purchaseorder{
    key PO_ID as ![PurchaseOrderNo],
    key Items.PO_ITEM_POS as ![Position],
    PARTNER_GUID.BP_ID as ![Vendor_ID],
    PARTNER_GUID.COMPANY_NAME as ![CompanyName],
    Items.GROSS_AMOUNT as ![GrossAmount],
    Items.TAX_AMOUNT as ![TaxAmount],
    case OVERALL_STATUS 
         when 'N' then 'New'
         when 'D' then 'Delivered'
         when 'P' then 'Pending'
         when 'A' then 'Approved'
         when 'X' then 'Rejected'
         end as ![Status],
    OVERALL_STATUS as ![OS],
    Items.PRODUCT_GUID.DESCRIPTION as ![Product],
    PARTNER_GUID.ADDRESS_GUID.COUNTRY as ![Country]
}

define view ![ProductVH] as 
     select from manaDB.master.Product{
        @EndUserText.label:[{
            language:'EN',
            text: 'Product ID'
        },
        {
            language:'DE',
            text: 'Prodekt ID'
        }]
         PRODUCT_ID as ![ProductID],
          @EndUserText.label:[{
            language:'EN',
            text: 'Product Name'
        },
        {
            language:'DE',
            text: 'Prodekt Nami'
        }]
         DESCRIPTION as ![ProductName]
     }

define view ![ItemView] as 
   select from manaDB.transaction.poitems{
    PARENT_KEY.PARTNER_GUID.NODE_KEY as ![VendorID],
    PRODUCT_GUID.NODE_KEY as ![ProductID],
    CURRENCY as ![Currency],
    GROSS_AMOUNT as ![GrossAmount],
    TAX_AMOUNT as ![TaxAmount],
    NET_AMOUNT as ![NetAmount],
    PARENT_KEY.OVERALL_STATUS as ![Status]
   }

define view ![ProdductOrders] as 
   select from manaDB.master.Product
   mixin{
     ORDERS : Association to many ItemView on ORDERS.ProductID = NODE_KEY
   }
   into { 
    NODE_KEY as ![ProductID],
    DESCRIPTION as ![ProductName],
    PRICE as ![Price],
    SUPPLIER_GUID.BP_ID as ![SupplierID],
    SUPPLIER_GUID.COMPANY_NAME as ![SupplierCompanyName],
    ORDERS as ![ProductOrders]
   }