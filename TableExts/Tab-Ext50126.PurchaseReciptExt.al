tableextension 50126 "Purchase Recipt Ext" extends "Purch. Rcpt. Header"
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
