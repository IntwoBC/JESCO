pageextension 50109 PostedPurchInvSubfrom_Ext extends "Posted Purch. Invoice Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field("Bill of Entry No."; Rec."Bill of Entry No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}