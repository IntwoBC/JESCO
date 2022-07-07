pageextension 50100 "Sales OrdersExt" extends "Sales Order List"
{
    layout
    {
        addafter(Amount)
        {
            field("Open Total Amount"; Rec."Open Total Amount")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addafter("&Print")
        {
            action(ProformaInvoice)
            {
                ApplicationArea = All;
                Caption = 'Jesco Proforma Invoice';
                Image = Print;

                trigger OnAction()
                var
                    SalesHeaderL: Record "Sales Header";
                begin
                    SalesHeaderL.SetRange("No.", Rec."No.");
                    SalesHeaderL.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");
                    if SalesHeaderL.FindFirst() then Report.Run(Report::"Jesco Sales-Proforma Invoice", true, true, SalesHeaderL);
                end;
            }
            action(UpdateLines)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category10;
                trigger OnAction()
                var
                    UpdateReport: Report "Sales Order Lines Update";
                begin
                    UpdateReport.Run();
                end;
            }
        }
    }
}