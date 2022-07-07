pageextension 50111 SalesInvSubform_Ext extends "Sales Invoice Subform"
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