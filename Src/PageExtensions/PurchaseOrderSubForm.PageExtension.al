pageextension 50107 "PurchOrderSubfrom_Ext" extends "Purchase Order Subform"
{
    layout
    {
        addafter("Qty. Assigned")
        {
            field("Bill of Entry No."; Rec."Bill of Entry No.")
            {
                ApplicationArea = All;
            }
        }
    }
}