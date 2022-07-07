pageextension 50102 "Assembly Bom Ext" extends "Assembly BOM"
{
    layout
    {
        addafter("Quantity per")
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
