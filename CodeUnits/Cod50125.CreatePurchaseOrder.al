codeunit 50125 CreatePurchaseOrder
{
    trigger OnRun()
    
    begin
       CreatePurchase(); 
    end;
    procedure CreatePurchase()
   var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        MaterialHeader: Record "Material Request Header";
        MaterialLine: Record "Material Request Line";
    begin
        if CheckVendorNo() then
            if Confirm('Do you Want to create a purchase order') then begin
                MaterialHeader.Reset();
                PurchaseHeader.Reset();
                PurchaseLine.Reset();
                //Create Purchase Header
                MaterialHeader.SetRange("No.", RequestNO);
                if MaterialHeader.FindFirst() then begin
                    PurchaseHeader.Init();
                    PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Order;
                    PurchaseHeader."Material Request No." := MaterialHeader."No.";
                    PurchaseHeader.Validate("Buy-from Vendor No.", VendorID);
                    PurchaseHeader.Insert(true);
                    MaterialHeader.Status := MaterialHeader.Status::Processed;
                    MaterialHeader."Used for PO" := true;
                    MaterialHeader.Modify();

                    MaterialLine.Reset();
                    MaterialLine.SetRange("Reqest No.", RequestNO);
                    //Create Purchase Line
                    if MaterialLine.FindFirst() then
                        repeat begin
                            PurchaseLine.Init();
                            PurchaseLine."Document No." := PurchaseHeader."No.";
                            PurchaseLine."Document Type" := PurchaseLine."Document Type"::Order;
                            PurchaseLine."Line No." := MaterialLine."Line No.";
                            PurchaseLine.Insert();
                            PurchaseLine.Validate(Type, PurchaseLine.Type::Item);
                            PurchaseLine.Validate("No.", MaterialLine."Part Number");
                            PurchaseLine.Validate("Location Code", MaterialLine."Location Code");
                            PurchaseLine.Validate(Quantity, MaterialLine.Quantity);
                            PurchaseLine.Modify();
                        end;
                        until MaterialLine.Next() = 0;
                end;
                Message('Purchase Order Created!');
            end;
    end;
    procedure CheckVendorNo(): Boolean
    begin
        if VendorID = '' then begin
            Message('Please Enter Vendor Number'+VendorID);
            exit(false);
        end
        else
            exit(true);
    end;
    procedure GetNumbers(RequestNo1:code[20];VendorID1:Code[20])
    begin
        RequestNO := RequestNo1;
        VendorID:=VendorID1;
    end;

    var
        VendorID: Code[20];
        RequestNO: Code[20];

    
}
