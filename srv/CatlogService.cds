
using { anubhav.db } from '../db/datamodel';
using { anubhav.cds } from '../db/CDSViews';

service CatalogService @(path:'CatalogService', requires: 'authenticated-user')  {
  @Capabilities:{Insertable,Updatable,Deletable:false}
    entity BusinessPartnerSet as projection on db.master.businesspartner;
    entity AddressSet as projection on db.master.address;
    
    entity EmployeeSet @(restrict: [ 
                        { grant: ['READ'], to: 'Viewer', where: 'bankName = $user.BankName' },
                        { grant: ['WRITE'], to: 'Admin' }
                        ])  as projection on db.master.employees;
    entity PurchaseOrderItems as projection on db.transaction.poitems;
   
    entity POs @(
        odata.draft.enabled: true,
        
    )  as projection on db.transaction.purchaseorder {
      CASE OVERALL_STATUS
      WHEN 'A' then 'Approved'
      WHEN 'P' then 'Pending'
      WHEN 'N' then 'New'
      WHEN 'X' then 'Rejected'
      WHEN 'D' then 'Deleted' end as overallstatus:String(32),
      case OVERALL_STATUS
            WHEN 'A' then 3
            WHEN 'X' then 1
            WHEN 'N' then 2
            WHEN 'D' then 3
            WHEN 'P' then 2 end as ColorCode: Integer,
    *,
    Items
    }
     actions{
        @cds.odata.bindingparameter.name: '_anubhav'
        @Common.SideEffects: {
            TargetProperties: ['_anubhav/GROSS_AMOUNT']
        }
        action boost();
        function largestOrder() returns array of POs;
    };
  //entity CProductValuesView as projection on cds.CDSViews.CProductValuesView;

  //entity CProductValuesView as projection on cds.CDSViews.CProductValuesView;
entity ProductSet as projection on db.master.product;
  
}