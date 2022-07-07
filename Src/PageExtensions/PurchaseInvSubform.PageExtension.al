pageextension 50112 PurchaseInvSubform_Ext extends "Purch. Invoice Subform"
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