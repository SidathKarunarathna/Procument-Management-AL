tableextension 50127 "Purchase Invoice Ext" extends "Purch. Inv. Header"
{
    fields
    {
        field(50100; "Material Request No."; Code[20])
        {
            Caption = 'Material Request No.';
            DataClassification = ToBeClassified;
        }
    }
}
