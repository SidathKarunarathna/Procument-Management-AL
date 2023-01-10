pageextension 50129 "Posted Purchase Recipt Ext" extends "Posted Purchase Receipt"
{
    layout
    {
        addafter("Order No.")
        {
            field("Material Request No."; Rec."Material Request No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}
