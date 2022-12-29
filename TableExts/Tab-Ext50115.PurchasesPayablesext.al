tableextension 50115 "Purchases & Payables ext" extends "Purchases & Payables Setup"
{
    fields
    {
        field(50100; "Material Rquest Nos"; Code[20])
        {
            Caption = 'Material Rquest Nos';
            DataClassification = ToBeClassified;
            TableRelation="No. Series";
        }
        
    }
}
