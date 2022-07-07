pageextension 50106 SalesOrderSubfrm_ext extends "Sales Order Subform"
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