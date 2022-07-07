pageextension 50129 "Item List Ext" extends "Item List"
{
    layout
    {
        addafter(InventoryField)
        {
            field("Qty. on Sales Quote"; Rec."Qty. on Sales Quote")
            {
                ApplicationArea = All;
            }
        }
    }
}