pageextension 50117 "Assemble Order_Ext" extends "Assembly Order"
{
    layout
    {
        addafter("Cost Amount")
        {
            field("Total Line Amount"; Rec."Total Line Amount")
            {
                ApplicationArea = All;
            }
            // field("Total Line Amount"; GettotalLineAmount)
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the total line amount of the assembly order.';
            // }
        }
    }

    // local procedure GettotalLineAmount(): Decimal
    // var
    //     AssemblyLineL: Record "Assembly Line";
    // begin
    //     AssemblyLineL.SetRange("Document Type", AssemblyLineL."Document Type"::Order);
    //     AssemblyLineL.SetRange("Document No.", Rec."No.");
    //     if AssemblyLineL.FindSet() then;
    //     AssemblyLineL.CalcSums("Line Amount");
    //     exit(AssemblyLineL."Line Amount");
    // end;

    // trigger OnOpenPage()
    // begin
    //     GettotalLineAmount;
    // end;
}