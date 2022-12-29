report 50123 "Vendor Selection Report"
{
    ApplicationArea = All;
    Caption = 'Vendor Selection Report';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;


    requestpage
    {
        layout
        {
            area(content)
            {
                group(Vendor)
                {
                    field(VendorID; VendorID)
                    {
                        ApplicationArea = all;
                        TableRelation = Vendor;
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    var
        CreatePurchaseOrder : Codeunit CreatePurchaseOrder;
    begin
        CreatePurchaseOrder.GetNumbers(RequestNO,VendorID);
        CreatePurchaseOrder.Run();
    end;

    procedure GetReqestNo(Material: Record "Material Request Header")
    begin
        RequestNO := Material."No.";
    end;

    var
        VendorID: Code[20];
        RequestNO: Code[20];
}
