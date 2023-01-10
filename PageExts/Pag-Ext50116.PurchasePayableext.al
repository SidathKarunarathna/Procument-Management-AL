pageextension 50116 "Purchase & Payable ext " extends "Purchases & Payables Setup"
{
    layout
    {
        addlast("Number Series")
        {
            field("Material Rquest Nos"; Rec."Material Rquest Nos")
            {
                ApplicationArea = All;
            }
            field("Vendor Invoice Nos";Rec."Vendor Invoice Nos")
            {
                ApplicationArea=All;
            }
        }
    }
}
