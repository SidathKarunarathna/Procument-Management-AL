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
        }
    }
}
