pageextension 50119 "Assembly QuoteSubfrm_Ext" extends "Assembly Quote Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field("Unit Price"; Rec."Unit Price")
            {
                ApplicationArea = All;
            }
            field("Discount %"; Rec."Discount %")
            {
                ApplicationArea = All;
            }
            field("Discount Amount"; Rec."Discount Amount")
            {
                ApplicationArea = All;
            }
            field("Line Amount"; Rec."Line Amount")
            {
                ApplicationArea = All;
            }
        }
    }
}
