pageextension 50128 "Posted Purchase Invoice Ext" extends "Posted Purchase Invoice"
{
    layout
    {
        addafter("Vendor Invoice No.")
        {
            field("Material Request No.";Rec."Material Request No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
