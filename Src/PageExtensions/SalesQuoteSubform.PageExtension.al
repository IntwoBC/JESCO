pageextension 50110 SalesQuoteSubform_Ext extends "Sales Quote Subform"
{
    layout
    {
        addafter("Qty. Assigned")
        {
            field("Bill of Entry No."; Rec."Bill of Entry No.")
            {
                ApplicationArea = All;
            }
            field("Custom Duty"; Rec."Custom Duty")
            {
                ApplicationArea = All;
            }
        }
        addbefore(Type)
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
            }
        }


        addafter("Subtotal Excl. VAT")
        {
            field("Duplicate Subtotal Excl. VAT"; Rec."Duplicate Sub Total")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            }
        }
    }
}