pageextension 50105 SalesQuote_Ext extends "Sales Quote"
{
    layout
    {
        addbefore("Work Description")
        {
            field("Valid Up to"; Rec."Valid Up to")
            {
                ApplicationArea = All;
            }
            field("Delivery Times"; Rec."Delivery Times")
            {
                ApplicationArea = All;
            }
            field("Your Reference 1"; Rec."Your Reference 1")
            {
                ApplicationArea = All;
            }
        }
        modify("Your Reference")
        {
            Visible = false;
        }
    }
    // actions
    // {
    //     addafter(AttachAsPDF)
    //     {
    //         action(ProjectSalesQuote)
    //         {
    //             Caption = 'Project sales Quote';
    //             Image = Print;
    //             ApplicationArea = All;
    //             trigger OnAction()
    //             var
    //                 SalesHeaderL: Record "Sales Header";
    //             begin
    //                 SalesHeaderL.SetRange("No.", Rec."No.");
    //                 SalesHeaderL.SetRange("Bill-to Customer No.", Rec."Bill-to Customer No.");
    //                 if SalesHeaderL.FindFirst() then
    //                     Report.Run(Report::"Jesco Sales - Project", true, false, SalesHeaderL);
    //             end;
    //         }
    //     }
    // }
}