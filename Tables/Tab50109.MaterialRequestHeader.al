table 50109 "Material Request Header"
{
    Caption = 'Material Request Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;


        }
        field(2; Status; Enum Status)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
        }
        field(3; "Used for PO"; Boolean)
        {
            Caption = 'Used for PO';
            DataClassification = ToBeClassified;
        }
        field(4; "Requested Name"; Text[100])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(5; "Staff No."; Code[20])
        {
            Caption = 'Staff No.';
            DataClassification = ToBeClassified;
        }
        field(6; Auth; Text[100])
        {
            Caption = 'Auth';
            DataClassification = ToBeClassified;
        }
        field(7; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(8; "Processed Name"; Text[100])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(9; "Sent for Processing Date"; Date)
        {
            Caption = 'Sent for Processing Date';
            DataClassification = ToBeClassified;
        }
        field(10; "Created Date"; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(11; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    procedure GetNoSeriesCode(): Code[20]
    var
        NoSeriesCode: Code[20];
    begin
        GetPurchaseSetup();
        NoSeriesCode := PurchaseSetup."Material Rquest Nos";
        exit(NoSeriesCode);
    end;


    local procedure GetPurchaseSetup()
    begin
        PurchaseSetup.Get();
    end;

    procedure InitInsert()
    begin
        if "No." = '' then begin
            TestNoSeries();
            NoSeriesMgt.InitSeries(GetNoSeriesCode(), xRec."No. Series", Today, "No.", "No. Series");
        end;
    end;

    procedure TestNoSeries()
    begin
        GetPurchaseSetup();
        PurchaseSetup.TestField("Material Rquest Nos");

    end;

    trigger OnInsert()
    begin
        InitInsert();
        "Created Date" := Today; //auto fill date
    end;

    var
        PurchaseSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

        

}
