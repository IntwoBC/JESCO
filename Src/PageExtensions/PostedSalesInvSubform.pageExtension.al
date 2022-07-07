pageextension 50108 PostedSalesInvSubform_Ext extends "Posted Sales Invoice Subform"
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