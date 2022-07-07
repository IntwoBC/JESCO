pageextension 50115 "AssemblytoOrder Line Ext" extends "Assemble-to-Order Lines"
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
